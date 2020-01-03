#include "gtest/gtest.h"

#include "testfile.hpp"

TEST(testfile, sum) {
  EXPECT_EQ(sum(2, 3), 5);
}