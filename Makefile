# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vinda-si <vinda-si@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/24 17:32:24 by vinda-si          #+#    #+#              #
#    Updated: 2025/05/25 19:31:06 by vinda-si         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		= fractol
CC			= cc
CFLAGS		= -Wall -Wextra -Werror
MLX_DIR		= minilibx-linux
INCLUDES	= -Iincludes -I$(MLX_DIR)
MLX_LIB		= $(MLX_DIR)/libmlx.a
MLX_FLAGS	= -L$(MLX_DIR) -lmlx -lXext -lX11

SRC_DIR		= src
SRC_FILES	= handlers.c init.c lib_utils.c main.c math.c render.c
SRCS		= $(addprefix $(SRC_DIR)/,$(SRC_FILES))
OBJ_DIR		= obj
OBJS		= $(addprefix $(OBJ_DIR)/,$(SRC_FILES:.c=.o))

all: $(NAME)

$(MLX_LIB):
	@make -C $(MLX_DIR)

$(NAME): $(MLX_LIB) $(OBJS)
	$(CC) $(CFLAGS) $(INCLUDES) $^ $(MLX_FLAGS) -o $@

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)
	@make -C $(MLX_DIR) clean

re: fclean all

install:
	cp $(NAME) /usr/local/bin

uninstall:
	rm -f /usr/local/bin/$(NAME)

.PHONY: all clean fclean re install uninstall