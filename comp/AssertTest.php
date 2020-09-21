<?php

use PHPUnit\Framework\TestCase;

class AssertTest extends TestCase
{
  /**
   * @test
   */
  public function verdadeiro()
  {
    $this->assertTrue(true);
  }
}