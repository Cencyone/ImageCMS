<link href="http://yandex.st/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
<script src="//api-maps.yandex.ru/2.0/?lang=ru-RU&load=package.standard,package.clusters" type="text/javascript"></script>

<script type="text/javascript">

    var a = [], u = [], d = [], im = [], id = [], p = [];
    {foreach $adr as $key=>$ad}
        a[{echo $key}] = '{echo $ad}';
    {/foreach}
    {foreach $url as $key=>$urr}
        u[{echo $key}] = '{echo $urr}';
    {/foreach}
    {foreach $desc as $key=>$dd}
        d[{echo $key}] = '{echo json_encode($dd)}';
    {/foreach}
    {foreach $img as $key=>$ii}
        im[{echo $key}] = '{echo $ii}';
    {/foreach}
    {foreach $ids as $key=>$idd}
        id[{echo $key}] = '{echo $idd}';
    {/foreach}
    {foreach $price as $key=>$p}
        p[{echo $key}] = '{echo number_format($p,2)}';
    {/foreach}

    {literal}
        ymaps.ready(function() {
            var myMap = window.map = new ymaps.Map('YMapsID', {
                center: [55.751574, 37.573856],
                zoom: 9,
                behaviors: ['default', 'scrollZoom']
            }),
            /**
             * Создадим кластеризатор, вызвав функцию-конструктор.
             * Список всех опций доступен в документации.
             * @see http://api.yandex.ru/maps/doc/jsapi/2.x/ref/reference/Clusterer.xml#constructor-summary
             */
            clusterer = new ymaps.Clusterer({
                /**
                 * Через кластеризатор можно указать только стили кластеров,
                 * стили для меток нужно назначать каждой метке отдельно.
                 * @see http://api.yandex.ru/maps/doc/jsapi/2.x/ref/reference/option.presetStorage.xml
                 */
                preset: 'twirl#invertedVioletClusterIcons',
                /**
                 * Ставим true, если хотим кластеризовать только точки с одинаковыми координатами.
                 */
                groupByCoordinates: false,
                /**
                 * Опции кластеров указываем в кластеризаторе с префиксом "cluster".
                 * @see http://api.yandex.ru/maps/doc/jsapi/2.x/ref/reference/Cluster.xml
                 */
                clusterDisableClickZoom: true
            }),
            /**
             * Функция возвращает объект-данных для метки.
             * Поле данных clusterCaption будет отображено в списке геообъектов в балуне кластера.
             * Поле balloonContentBody - источник данных для контента балуна.
             * Оба поля поддерживают HTML-разметку.
             * Список полей данных, которые используют стандартные макеты содержимого иконки метки
             * и балуна геообъектов, можно посмотреть в документации.
             * @see http://api.yandex.ru/maps/doc/jsapi/2.x/ref/reference/GeoObject.xml
             */
            getPointData = function(index, url, desc, img, id, price) {
                console.log(index);
                return {
                    balloonContentBody: '<a href="/shop/product/' + url + '"><strong>' + index + '</strong></a><img src="/uploads/shop/'+img+'"></img><p>ID: '+id+'</p><p>Цена от: '+price.toString()+' рублей</p>' + desc,
                    clusterCaption: '<strong>' + index + '</strong>'
                };
            },
                    /**
                     * Функция возвращает объект-опций для метки.
                     * Все опции, которые поддерживают геообъекты можно посмотреть в документации.
                     * @see http://api.yandex.ru/maps/doc/jsapi/2.x/ref/reference/GeoObject.xml
                     */
                    getPointOptions = function() {
                        return {
                            preset: 'twirl#violetIcon'
                        };
                    },
                    points = [{/literal}{echo $crd}{literal}],
                    //points = [[55.831903, 37.411961], [55.763338, 37.565466], [55.763338, 37.565466], [55.744522, 37.616378], [55.780898, 37.642889], [55.793559, 37.435983], [55.800584, 37.675638], [55.716733, 37.589988], [55.775724, 37.560840], [55.822144, 37.433781], [55.874170, 37.669838], [55.716770, 37.482338], [55.780850, 37.750210], [55.810906, 37.654142], [55.865386, 37.713329], [55.847121, 37.525797], [55.778655, 37.710743], [55.623415, 37.717934], [55.863193, 37.737000], [55.866770, 37.760113], [55.698261, 37.730838], [55.633800, 37.564769], [55.639996, 37.539400], [55.690230, 37.405853], [55.775970, 37.512900], [55.775777, 37.442180], [55.811814, 37.440448], [55.751841, 37.404853], [55.627303, 37.728976], [55.816515, 37.597163], [55.664352, 37.689397], [55.679195, 37.600961], [55.673873, 37.658425], [55.681006, 37.605126], [55.876327, 37.431744], [55.843363, 37.778445], [55.875445, 37.549348], [55.662903, 37.702087], [55.746099, 37.434113], [55.838660, 37.712326], [55.774838, 37.415725], [55.871539, 37.630223], [55.657037, 37.571271], [55.691046, 37.711026], [55.803972, 37.659610], [55.616448, 37.452759], [55.781329, 37.442781], [55.844708, 37.748870], [55.723123, 37.406067], [55.858585, 37.484980]],
                    geoObjects = [];

            /**
             * Данные передаются вторым параметром в конструктор метки, опции третьим.
             * @see http://api.yandex.ru/maps/doc/jsapi/2.x/ref/reference/Placemark.xml#constructor-summary
             */
            for (var i = 0, len = points.length; i < len; i++) {
                geoObjects[i] = new ymaps.Placemark(points[i], getPointData(a[i], u[i], d[i], im[i], id[i], p[i]), getPointOptions());
                /**
                 * Так же их можно добавлять/менять динамически после создания меток.
                 * geoObjects[i].properties.set(getPointData(i));
                 * geoObjects[i].options.set(getPointOptions());
                 */
            }

            /**
             * Так же можно менять опции кластеризатора.
             */
            clusterer.options.set({
                gridSize: 80,
                clusterDisableClickZoom: true
            });

            /**
             * В кластеризатор можно добавить javascript-массив меток (не геоколлекцию) или одну метку.
             * @see http://api.yandex.ru/maps/doc/jsapi/2.x/ref/reference/Clusterer.xml#add
             */
            clusterer.add(geoObjects);

            /**
             * Поскольку кластеры добавляются асинхронно,
             * дождемся их добавления, чтобы выставить карте область, которую они занимают.
             * Используем метод once чтобы сделать это один раз.
             */
            clusterer.events.once('objectsaddtomap', function() {
                myMap.setBounds(clusterer.getBounds());
            });

            /**
             * Кластеризатор, расширяет коллекцию, что позволяет использовать один обработчик
             * для обработки событий всех геообъектов.
             * Выведем текущий гееобъект, на который навели курсор, поверх остальных.
             */
            clusterer.events
                    // Можно слушать сразу несколько событий, указывая их имена в массиве.
                    .add(['mouseenter', 'mouseleave'], function(e) {
                        var target = e.get('target'), // Геообъект - источник события.
                                eType = e.get('type'), // Тип события.
                                zIndex = Number(eType === 'mouseenter') * 1000; // 1000 или 0 в зависимости от типа события.

                        target.options.set('zIndex', zIndex);
                    });

            /**
             * После добавления массива геообъектов в кластеризатор,
             * работать с геообъектами можно, имея ссылку на этот массив.
             */
            clusterer.events.add('objectsaddtomap', function() {
                for (var i = 0, len = geoObjects.length; i < len; i++) {
                    var geoObject = geoObjects[i],
                            /**
                             * Информацию о текущем состоянии геообъекта, добавленного в кластеризатор,
                             * а также ссылку на кластер, в который добавлен геообъект, можно получить с помощью метода getObjectState.
                             * @see http://api.yandex.ru/maps/doc/jsapi/2.x/ref/reference/Clusterer.xml#getObjectState
                             */
                            geoObjectState = clusterer.getObjectState(geoObject),
                            // признак, указывающий, находится ли объект в видимой области карты
                            isShown = geoObjectState.isShown,
                            // признак, указывающий, попал ли объект в состав кластера
                            isClustered = geoObjectState.isClustered,
                            // ссылка на кластер, в который добавлен объект
                            cluster = geoObjectState.cluster;

                    if (window.console) {
                        console.log('Геообъект: %s, находится в видимой области карты: %s, в составе кластера: %s', i, isShown, isClustered);
                    }
                }
            });

            myMap.geoObjects.add(clusterer);
            var myGeocoder = ymaps.geocode("Туристская улица, дом 16, корпус 4 москва");
            myGeocoder.then(
                    function(res) {
                        a = res.geoObjects.get(0).geometry.getCoordinates();
                        console.log(a)
                    },
                    function(err) {
                        //alert('Ошибка');
                    }
            );

        });


    </script>
    <style type="text/css">
        #YMapsID {
            width: 800px;
            height: 400px;
        }
    </style>

{/literal}

<div class="hero-unit">
    <div class="container">
        <div id="YMapsID"></div>
    </div>
</div>