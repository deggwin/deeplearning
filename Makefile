CXXFLAGS = -Wall -Wextra -std=c++17 -Iheaders -Iincludes

ifeq ($(OS), Windows_NT)
    CXXFLAGS += -I$(VULKAN_SDK)/Include
    LDFLAGS = -L$(VULKAN_SDK)/Lib -lvulkan-1 -lglfw3 -lopengl32 -lgdi32 -Llibs
    WIN = true
else
    UNAME_S = $(shell uname -s)
    ifeq ($(UNAME_S), Linux)
        CXXFLAGS += -I/usr/include  # Add Vulkan headers if not system default
        LDFLAGS = -lvulkan -lglfw -lGL -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi
        WIN = false
    endif
endif

all:
	g++ $(CXXFLAGS) ./src/main.cpp -o vulkan-proj $(LDFLAGS)

run: all
	./vulkan-proj

clean:
	ifeq (WIN)
		del main
	else
		rm -f main
	endif
