<?php

namespace mod_link\models\Base;

use \Exception;
use \PDO;
use Propel\Runtime\Propel;
use Propel\Runtime\ActiveQuery\Criteria;
use Propel\Runtime\ActiveQuery\ModelCriteria;
use Propel\Runtime\ActiveQuery\ModelJoin;
use Propel\Runtime\Collection\ObjectCollection;
use Propel\Runtime\Connection\ConnectionInterface;
use Propel\Runtime\Exception\PropelException;
use mod_link\models\PageLinkProduct as ChildPageLinkProduct;
use mod_link\models\PageLinkProductQuery as ChildPageLinkProductQuery;
use mod_link\models\Map\PageLinkProductTableMap;

/**
 * Base class that represents a query for the 'page_link_product' table.
 *
 *
 *
 * @method     ChildPageLinkProductQuery orderByLinkId($order = Criteria::ASC) Order by the link_id column
 * @method     ChildPageLinkProductQuery orderByProductId($order = Criteria::ASC) Order by the product_id column
 *
 * @method     ChildPageLinkProductQuery groupByLinkId() Group by the link_id column
 * @method     ChildPageLinkProductQuery groupByProductId() Group by the product_id column
 *
 * @method     ChildPageLinkProductQuery leftJoin($relation) Adds a LEFT JOIN clause to the query
 * @method     ChildPageLinkProductQuery rightJoin($relation) Adds a RIGHT JOIN clause to the query
 * @method     ChildPageLinkProductQuery innerJoin($relation) Adds a INNER JOIN clause to the query
 *
 * @method     ChildPageLinkProductQuery leftJoinWith($relation) Adds a LEFT JOIN clause and with to the query
 * @method     ChildPageLinkProductQuery rightJoinWith($relation) Adds a RIGHT JOIN clause and with to the query
 * @method     ChildPageLinkProductQuery innerJoinWith($relation) Adds a INNER JOIN clause and with to the query
 *
 * @method     ChildPageLinkProductQuery leftJoinPageLink($relationAlias = null) Adds a LEFT JOIN clause to the query using the PageLink relation
 * @method     ChildPageLinkProductQuery rightJoinPageLink($relationAlias = null) Adds a RIGHT JOIN clause to the query using the PageLink relation
 * @method     ChildPageLinkProductQuery innerJoinPageLink($relationAlias = null) Adds a INNER JOIN clause to the query using the PageLink relation
 *
 * @method     ChildPageLinkProductQuery joinWithPageLink($joinType = Criteria::INNER_JOIN) Adds a join clause and with to the query using the PageLink relation
 *
 * @method     ChildPageLinkProductQuery leftJoinWithPageLink() Adds a LEFT JOIN clause and with to the query using the PageLink relation
 * @method     ChildPageLinkProductQuery rightJoinWithPageLink() Adds a RIGHT JOIN clause and with to the query using the PageLink relation
 * @method     ChildPageLinkProductQuery innerJoinWithPageLink() Adds a INNER JOIN clause and with to the query using the PageLink relation
 *
 * @method     \mod_link\models\PageLinkQuery endUse() Finalizes a secondary criteria and merges it with its primary Criteria
 *
 * @method     ChildPageLinkProduct findOne(ConnectionInterface $con = null) Return the first ChildPageLinkProduct matching the query
 * @method     ChildPageLinkProduct findOneOrCreate(ConnectionInterface $con = null) Return the first ChildPageLinkProduct matching the query, or a new ChildPageLinkProduct object populated from the query conditions when no match is found
 *
 * @method     ChildPageLinkProduct findOneByLinkId(int $link_id) Return the first ChildPageLinkProduct filtered by the link_id column
 * @method     ChildPageLinkProduct findOneByProductId(int $product_id) Return the first ChildPageLinkProduct filtered by the product_id column *

 * @method     ChildPageLinkProduct requirePk($key, ConnectionInterface $con = null) Return the ChildPageLinkProduct by primary key and throws \Propel\Runtime\Exception\EntityNotFoundException when not found
 * @method     ChildPageLinkProduct requireOne(ConnectionInterface $con = null) Return the first ChildPageLinkProduct matching the query and throws \Propel\Runtime\Exception\EntityNotFoundException when not found
 *
 * @method     ChildPageLinkProduct requireOneByLinkId(int $link_id) Return the first ChildPageLinkProduct filtered by the link_id column and throws \Propel\Runtime\Exception\EntityNotFoundException when not found
 * @method     ChildPageLinkProduct requireOneByProductId(int $product_id) Return the first ChildPageLinkProduct filtered by the product_id column and throws \Propel\Runtime\Exception\EntityNotFoundException when not found
 *
 * @method     ChildPageLinkProduct[]|ObjectCollection find(ConnectionInterface $con = null) Return ChildPageLinkProduct objects based on current ModelCriteria
 * @method     ChildPageLinkProduct[]|ObjectCollection findByLinkId(int $link_id) Return ChildPageLinkProduct objects filtered by the link_id column
 * @method     ChildPageLinkProduct[]|ObjectCollection findByProductId(int $product_id) Return ChildPageLinkProduct objects filtered by the product_id column
 * @method     ChildPageLinkProduct[]|\Propel\Runtime\Util\PropelModelPager paginate($page = 1, $maxPerPage = 10, ConnectionInterface $con = null) Issue a SELECT query based on the current ModelCriteria and uses a page and a maximum number of results per page to compute an offset and a limit
 *
 */
abstract class PageLinkProductQuery extends ModelCriteria
{
    protected $entityNotFoundExceptionClass = '\\Propel\\Runtime\\Exception\\EntityNotFoundException';

    /**
     * Initializes internal state of \mod_link\models\Base\PageLinkProductQuery object.
     *
     * @param     string $dbName The database name
     * @param     string $modelName The phpName of a model, e.g. 'Book'
     * @param     string $modelAlias The alias for the model in this query, e.g. 'b'
     */
    public function __construct($dbName = 'Shop', $modelName = '\\mod_link\\models\\PageLinkProduct', $modelAlias = null)
    {
        parent::__construct($dbName, $modelName, $modelAlias);
    }

    /**
     * Returns a new ChildPageLinkProductQuery object.
     *
     * @param     string $modelAlias The alias of a model in the query
     * @param     Criteria $criteria Optional Criteria to build the query from
     *
     * @return ChildPageLinkProductQuery
     */
    public static function create($modelAlias = null, Criteria $criteria = null)
    {
        if ($criteria instanceof ChildPageLinkProductQuery) {
            return $criteria;
        }
        $query = new ChildPageLinkProductQuery();
        if (null !== $modelAlias) {
            $query->setModelAlias($modelAlias);
        }
        if ($criteria instanceof Criteria) {
            $query->mergeWith($criteria);
        }

        return $query;
    }

    /**
     * Find object by primary key.
     * Propel uses the instance pool to skip the database if the object exists.
     * Go fast if the query is untouched.
     *
     * <code>
     * $obj = $c->findPk(array(12, 34), $con);
     * </code>
     *
     * @param array[$link_id, $product_id] $key Primary key to use for the query
     * @param ConnectionInterface $con an optional connection object
     *
     * @return ChildPageLinkProduct|array|mixed the result, formatted by the current formatter
     */
    public function findPk($key, ConnectionInterface $con = null)
    {
        if ($key === null) {
            return null;
        }

        if ($con === null) {
            $con = Propel::getServiceContainer()->getReadConnection(PageLinkProductTableMap::DATABASE_NAME);
        }

        $this->basePreSelect($con);

        if (
            $this->formatter || $this->modelAlias || $this->with || $this->select
            || $this->selectColumns || $this->asColumns || $this->selectModifiers
            || $this->map || $this->having || $this->joins
        ) {
            return $this->findPkComplex($key, $con);
        }

        if ((null !== ($obj = PageLinkProductTableMap::getInstanceFromPool(serialize([(null === $key[0] || is_scalar($key[0]) || is_callable([$key[0], '__toString']) ? (string) $key[0] : $key[0]), (null === $key[1] || is_scalar($key[1]) || is_callable([$key[1], '__toString']) ? (string) $key[1] : $key[1])]))))) {
            // the object is already in the instance pool
            return $obj;
        }

        return $this->findPkSimple($key, $con);
    }

    /**
     * Find object by primary key using raw SQL to go fast.
     * Bypass doSelect() and the object formatter by using generated code.
     *
     * @param     mixed $key Primary key to use for the query
     * @param     ConnectionInterface $con A connection object
     *
     * @throws \Propel\Runtime\Exception\PropelException
     *
     * @return ChildPageLinkProduct A model object, or null if the key is not found
     */
    protected function findPkSimple($key, ConnectionInterface $con)
    {
        $sql = 'SELECT link_id, product_id FROM page_link_product WHERE link_id = :p0 AND product_id = :p1';
        try {
            $stmt = $con->prepare($sql);
            $stmt->bindValue(':p0', $key[0], PDO::PARAM_INT);
            $stmt->bindValue(':p1', $key[1], PDO::PARAM_INT);
            $stmt->execute();
        } catch (Exception $e) {
            Propel::log($e->getMessage(), Propel::LOG_ERR);
            throw new PropelException(sprintf('Unable to execute SELECT statement [%s]', $sql), 0, $e);
        }
        $obj = null;
        if ($row = $stmt->fetch(\PDO::FETCH_NUM)) {
            /** @var ChildPageLinkProduct $obj */
            $obj = new ChildPageLinkProduct();
            $obj->hydrate($row);
            PageLinkProductTableMap::addInstanceToPool($obj, serialize([(null === $key[0] || is_scalar($key[0]) || is_callable([$key[0], '__toString']) ? (string) $key[0] : $key[0]), (null === $key[1] || is_scalar($key[1]) || is_callable([$key[1], '__toString']) ? (string) $key[1] : $key[1])]));
        }
        $stmt->closeCursor();

        return $obj;
    }

    /**
     * Find object by primary key.
     *
     * @param     mixed $key Primary key to use for the query
     * @param     ConnectionInterface $con A connection object
     *
     * @return ChildPageLinkProduct|array|mixed the result, formatted by the current formatter
     */
    protected function findPkComplex($key, ConnectionInterface $con)
    {
        // As the query uses a PK condition, no limit(1) is necessary.
        $criteria = $this->isKeepQuery() ? clone $this : $this;
        $dataFetcher = $criteria
            ->filterByPrimaryKey($key)
            ->doSelect($con);

        return $criteria->getFormatter()->init($criteria)->formatOne($dataFetcher);
    }

    /**
     * Find objects by primary key
     * <code>
     * $objs = $c->findPks(array(array(12, 56), array(832, 123), array(123, 456)), $con);
     * </code>
     * @param     array $keys Primary keys to use for the query
     * @param     ConnectionInterface $con an optional connection object
     *
     * @return ObjectCollection|array|mixed the list of results, formatted by the current formatter
     */
    public function findPks($keys, ConnectionInterface $con = null)
    {
        if (null === $con) {
            $con = Propel::getServiceContainer()->getReadConnection($this->getDbName());
        }
        $this->basePreSelect($con);
        $criteria = $this->isKeepQuery() ? clone $this : $this;
        $dataFetcher = $criteria
            ->filterByPrimaryKeys($keys)
            ->doSelect($con);

        return $criteria->getFormatter()->init($criteria)->format($dataFetcher);
    }

    /**
     * Filter the query by primary key
     *
     * @param     mixed $key Primary key to use for the query
     *
     * @return $this|ChildPageLinkProductQuery The current query, for fluid interface
     */
    public function filterByPrimaryKey($key)
    {
        $this->addUsingAlias(PageLinkProductTableMap::COL_LINK_ID, $key[0], Criteria::EQUAL);
        $this->addUsingAlias(PageLinkProductTableMap::COL_PRODUCT_ID, $key[1], Criteria::EQUAL);

        return $this;
    }

    /**
     * Filter the query by a list of primary keys
     *
     * @param     array $keys The list of primary key to use for the query
     *
     * @return $this|ChildPageLinkProductQuery The current query, for fluid interface
     */
    public function filterByPrimaryKeys($keys)
    {
        if (empty($keys)) {
            return $this->add(null, '1<>1', Criteria::CUSTOM);
        }
        foreach ($keys as $key) {
            $cton0 = $this->getNewCriterion(PageLinkProductTableMap::COL_LINK_ID, $key[0], Criteria::EQUAL);
            $cton1 = $this->getNewCriterion(PageLinkProductTableMap::COL_PRODUCT_ID, $key[1], Criteria::EQUAL);
            $cton0->addAnd($cton1);
            $this->addOr($cton0);
        }

        return $this;
    }

    /**
     * Filter the query on the link_id column
     *
     * Example usage:
     * <code>
     * $query->filterByLinkId(1234); // WHERE link_id = 1234
     * $query->filterByLinkId(array(12, 34)); // WHERE link_id IN (12, 34)
     * $query->filterByLinkId(array('min' => 12)); // WHERE link_id > 12
     * </code>
     *
     * @see       filterByPageLink()
     *
     * @param     mixed $linkId The value to use as filter.
     *              Use scalar values for equality.
     *              Use array values for in_array() equivalent.
     *              Use associative array('min' => $minValue, 'max' => $maxValue) for intervals.
     * @param     string $comparison Operator to use for the column comparison, defaults to Criteria::EQUAL
     *
     * @return $this|ChildPageLinkProductQuery The current query, for fluid interface
     */
    public function filterByLinkId($linkId = null, $comparison = null)
    {
        if (is_array($linkId)) {
            $useMinMax = false;
            if (isset($linkId['min'])) {
                $this->addUsingAlias(PageLinkProductTableMap::COL_LINK_ID, $linkId['min'], Criteria::GREATER_EQUAL);
                $useMinMax = true;
            }
            if (isset($linkId['max'])) {
                $this->addUsingAlias(PageLinkProductTableMap::COL_LINK_ID, $linkId['max'], Criteria::LESS_EQUAL);
                $useMinMax = true;
            }
            if ($useMinMax) {
                return $this;
            }
            if (null === $comparison) {
                $comparison = Criteria::IN;
            }
        }

        return $this->addUsingAlias(PageLinkProductTableMap::COL_LINK_ID, $linkId, $comparison);
    }

    /**
     * Filter the query on the product_id column
     *
     * Example usage:
     * <code>
     * $query->filterByProductId(1234); // WHERE product_id = 1234
     * $query->filterByProductId(array(12, 34)); // WHERE product_id IN (12, 34)
     * $query->filterByProductId(array('min' => 12)); // WHERE product_id > 12
     * </code>
     *
     * @param     mixed $productId The value to use as filter.
     *              Use scalar values for equality.
     *              Use array values for in_array() equivalent.
     *              Use associative array('min' => $minValue, 'max' => $maxValue) for intervals.
     * @param     string $comparison Operator to use for the column comparison, defaults to Criteria::EQUAL
     *
     * @return $this|ChildPageLinkProductQuery The current query, for fluid interface
     */
    public function filterByProductId($productId = null, $comparison = null)
    {
        if (is_array($productId)) {
            $useMinMax = false;
            if (isset($productId['min'])) {
                $this->addUsingAlias(PageLinkProductTableMap::COL_PRODUCT_ID, $productId['min'], Criteria::GREATER_EQUAL);
                $useMinMax = true;
            }
            if (isset($productId['max'])) {
                $this->addUsingAlias(PageLinkProductTableMap::COL_PRODUCT_ID, $productId['max'], Criteria::LESS_EQUAL);
                $useMinMax = true;
            }
            if ($useMinMax) {
                return $this;
            }
            if (null === $comparison) {
                $comparison = Criteria::IN;
            }
        }

        return $this->addUsingAlias(PageLinkProductTableMap::COL_PRODUCT_ID, $productId, $comparison);
    }

    /**
     * Filter the query by a related \mod_link\models\PageLink object
     *
     * @param \mod_link\models\PageLink|ObjectCollection $pageLink The related object(s) to use as filter
     * @param string $comparison Operator to use for the column comparison, defaults to Criteria::EQUAL
     *
     * @throws \Propel\Runtime\Exception\PropelException
     *
     * @return ChildPageLinkProductQuery The current query, for fluid interface
     */
    public function filterByPageLink($pageLink, $comparison = null)
    {
        if ($pageLink instanceof \mod_link\models\PageLink) {
            return $this
                ->addUsingAlias(PageLinkProductTableMap::COL_LINK_ID, $pageLink->getId(), $comparison);
        } elseif ($pageLink instanceof ObjectCollection) {
            if (null === $comparison) {
                $comparison = Criteria::IN;
            }

            return $this
                ->addUsingAlias(PageLinkProductTableMap::COL_LINK_ID, $pageLink->toKeyValue('PrimaryKey', 'Id'), $comparison);
        } else {
            throw new PropelException('filterByPageLink() only accepts arguments of type \mod_link\models\PageLink or Collection');
        }
    }

    /**
     * Adds a JOIN clause to the query using the PageLink relation
     *
     * @param     string $relationAlias optional alias for the relation
     * @param     string $joinType Accepted values are null, 'left join', 'right join', 'inner join'
     *
     * @return $this|ChildPageLinkProductQuery The current query, for fluid interface
     */
    public function joinPageLink($relationAlias = null, $joinType = Criteria::INNER_JOIN)
    {
        $tableMap = $this->getTableMap();
        $relationMap = $tableMap->getRelation('PageLink');

        // create a ModelJoin object for this join
        $join = new ModelJoin();
        $join->setJoinType($joinType);
        $join->setRelationMap($relationMap, $this->useAliasInSQL ? $this->getModelAlias() : null, $relationAlias);
        if ($previousJoin = $this->getPreviousJoin()) {
            $join->setPreviousJoin($previousJoin);
        }

        // add the ModelJoin to the current object
        if ($relationAlias) {
            $this->addAlias($relationAlias, $relationMap->getRightTable()->getName());
            $this->addJoinObject($join, $relationAlias);
        } else {
            $this->addJoinObject($join, 'PageLink');
        }

        return $this;
    }

    /**
     * Use the PageLink relation PageLink object
     *
     * @see useQuery()
     *
     * @param     string $relationAlias optional alias for the relation,
     *                                   to be used as main alias in the secondary query
     * @param     string $joinType Accepted values are null, 'left join', 'right join', 'inner join'
     *
     * @return \mod_link\models\PageLinkQuery A secondary query class using the current class as primary query
     */
    public function usePageLinkQuery($relationAlias = null, $joinType = Criteria::INNER_JOIN)
    {
        return $this
            ->joinPageLink($relationAlias, $joinType)
            ->useQuery($relationAlias ? $relationAlias : 'PageLink', '\mod_link\models\PageLinkQuery');
    }

    /**
     * Exclude object from result
     *
     * @param   ChildPageLinkProduct $pageLinkProduct Object to remove from the list of results
     *
     * @return $this|ChildPageLinkProductQuery The current query, for fluid interface
     */
    public function prune($pageLinkProduct = null)
    {
        if ($pageLinkProduct) {
            $this->addCond('pruneCond0', $this->getAliasedColName(PageLinkProductTableMap::COL_LINK_ID), $pageLinkProduct->getLinkId(), Criteria::NOT_EQUAL);
            $this->addCond('pruneCond1', $this->getAliasedColName(PageLinkProductTableMap::COL_PRODUCT_ID), $pageLinkProduct->getProductId(), Criteria::NOT_EQUAL);
            $this->combine(array('pruneCond0', 'pruneCond1'), Criteria::LOGICAL_OR);
        }

        return $this;
    }

    /**
     * Deletes all rows from the page_link_product table.
     *
     * @param ConnectionInterface $con the connection to use
     * @return int The number of affected rows (if supported by underlying database driver).
     */
    public function doDeleteAll(ConnectionInterface $con = null)
    {
        if (null === $con) {
            $con = Propel::getServiceContainer()->getWriteConnection(PageLinkProductTableMap::DATABASE_NAME);
        }

        // use transaction because $criteria could contain info
        // for more than one table or we could emulating ON DELETE CASCADE, etc.
        return $con->transaction(function () use ($con) {
            $affectedRows = 0; // initialize var to track total num of affected rows
            $affectedRows += parent::doDeleteAll($con);
            // Because this db requires some delete cascade/set null emulation, we have to
            // clear the cached instance *after* the emulation has happened (since
            // instances get re-added by the select statement contained therein).
            PageLinkProductTableMap::clearInstancePool();
            PageLinkProductTableMap::clearRelatedInstancePool();

            return $affectedRows;
        });
    }

    /**
     * Performs a DELETE on the database based on the current ModelCriteria
     *
     * @param ConnectionInterface $con the connection to use
     * @return int             The number of affected rows (if supported by underlying database driver).  This includes CASCADE-related rows
     *                         if supported by native driver or if emulated using Propel.
     * @throws PropelException Any exceptions caught during processing will be
     *                         rethrown wrapped into a PropelException.
     */
    public function delete(ConnectionInterface $con = null)
    {
        if (null === $con) {
            $con = Propel::getServiceContainer()->getWriteConnection(PageLinkProductTableMap::DATABASE_NAME);
        }

        $criteria = $this;

        // Set the correct dbName
        $criteria->setDbName(PageLinkProductTableMap::DATABASE_NAME);

        // use transaction because $criteria could contain info
        // for more than one table or we could emulating ON DELETE CASCADE, etc.
        return $con->transaction(function () use ($con, $criteria) {
            $affectedRows = 0; // initialize var to track total num of affected rows

            PageLinkProductTableMap::removeInstanceFromPool($criteria);

            $affectedRows += ModelCriteria::delete($con);
            PageLinkProductTableMap::clearRelatedInstancePool();

            return $affectedRows;
        });
    }

} // PageLinkProductQuery