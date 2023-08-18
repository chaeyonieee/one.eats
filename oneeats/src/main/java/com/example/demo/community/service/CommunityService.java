package com.example.demo.community.service;

import java.util.List;
import java.util.Map;

import com.example.demo.vo.RecipeVO;

public interface CommunityService {

	public List<RecipeVO> selectRecipeList(Map pagingMap);

	public List<RecipeVO> selectNewRecipeList();

	public RecipeVO selectRecipeByRecipeNo(int recipeNo);

	public List<Map> selectingredientByRecipeNo(int recipeNo);

}