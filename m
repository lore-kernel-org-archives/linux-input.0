From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: sparse-keymap - use a managed allocation for
 keymap copy
Date: Wed, 8 Mar 2017 10:12:50 -0800
Message-ID: <20170308181250.GC20567@dtor-ws>
References: <20170308082217.5466-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170308082217.5466-1-kernel@kempniu.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 08, 2017 at 09:22:17AM +0100, Michał Kępień wrote:
> Some platform drivers use devm_input_allocate_device() together with
> sparse_keymap_setup() in their .probe callbacks.  While using the former
> simplifies error handling, using the latter necessitates calling
> sparse_keymap_free() in the error path and upon module unloading to
> avoid leaking the copy of the keymap allocated by sparse_keymap_setup().
> 
> To help prevent such leaks and enable simpler error handling, make
> sparse_keymap_setup() use devm_kmemdup() to create the keymap copy so
> that it gets automatically freed.
> 
> This works for both managed and non-managed input devices as the keymap
> is freed after the last reference to the input device is dropped.
> 
> Note that actions previously taken by sparse_keymap_free(), i.e. taking
> the input device's mutex and zeroing its keycode and keycodemax fields,
> are now redundant because the managed keymap will always be freed after
> the input device is unregistered.
> 
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>

OK, I think this looks good. Do platform folks want an immutable branch
off 4.10 with this change so we can start cleaning sparse_keymap_free()
users in this cycle?

> ---
> Changes from v2:
> 
>   - Always use the input device as the owner of the managed keymap copy,
>     no matter whether that input device is itself managed or
>     non-managed.
> 
>   - Use devm_kmemdup() instead of devm_kcalloc() to avoid a separate
>     call to memcpy().
> 
>   - Update commit message to reflect the above changes.
> 
> Changes from v1:
> 
>   - Do not add a new function.  Instead, make sparse_keymap_setup()
>     always use a managed allocation, which allows making
>     sparse_keymap_free() a noop and simplifies error handling.
> 
>   - Update subject, commit message and comments accordingly.
> 
>  drivers/input/sparse-keymap.c | 39 +++++++++------------------------------
>  1 file changed, 9 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
> index e7409c45bdd0..12a3ad83296d 100644
> --- a/drivers/input/sparse-keymap.c
> +++ b/drivers/input/sparse-keymap.c
> @@ -160,12 +160,12 @@ static int sparse_keymap_setkeycode(struct input_dev *dev,
>   * @keymap: Keymap in form of array of &key_entry structures ending
>   *	with %KE_END type entry
>   * @setup: Function that can be used to adjust keymap entries
> - *	depending on device's deeds, may be %NULL
> + *	depending on device's needs, may be %NULL
>   *
>   * The function calculates size and allocates copy of the original
>   * keymap after which sets up input device event bits appropriately.
> - * Before destroying input device allocated keymap should be freed
> - * with a call to sparse_keymap_free().
> + * The allocated copy of the keymap is automatically freed when it
> + * is no longer needed.
>   */
>  int sparse_keymap_setup(struct input_dev *dev,
>  			const struct key_entry *keymap,
> @@ -180,19 +180,18 @@ int sparse_keymap_setup(struct input_dev *dev,
>  	for (e = keymap; e->type != KE_END; e++)
>  		map_size++;
>  
> -	map = kcalloc(map_size, sizeof(struct key_entry), GFP_KERNEL);
> +	map = devm_kmemdup(&dev->dev, keymap, map_size * sizeof(*map),
> +			   GFP_KERNEL);
>  	if (!map)
>  		return -ENOMEM;
>  
> -	memcpy(map, keymap, map_size * sizeof(struct key_entry));
> -
>  	for (i = 0; i < map_size; i++) {
>  		entry = &map[i];
>  
>  		if (setup) {
>  			error = setup(dev, entry);
>  			if (error)
> -				goto err_out;
> +				return error;
>  		}
>  
>  		switch (entry->type) {
> @@ -221,10 +220,6 @@ int sparse_keymap_setup(struct input_dev *dev,
>  	dev->setkeycode = sparse_keymap_setkeycode;
>  
>  	return 0;
> -
> - err_out:
> -	kfree(map);
> -	return error;
>  }
>  EXPORT_SYMBOL(sparse_keymap_setup);
>  
> @@ -232,29 +227,13 @@ EXPORT_SYMBOL(sparse_keymap_setup);
>   * sparse_keymap_free - free memory allocated for sparse keymap
>   * @dev: Input device using sparse keymap
>   *
> - * This function is used to free memory allocated by sparse keymap
> + * This function used to free memory allocated by sparse keymap
>   * in an input device that was set up by sparse_keymap_setup().
> - * NOTE: It is safe to cal this function while input device is
> - * still registered (however the drivers should care not to try to
> - * use freed keymap and thus have to shut off interrupts/polling
> - * before freeing the keymap).
> + * Since sparse_keymap_setup() now uses a managed allocation for the
> + * keymap copy, use of this function is deprecated.
>   */
>  void sparse_keymap_free(struct input_dev *dev)
>  {
> -	unsigned long flags;
> -
> -	/*
> -	 * Take event lock to prevent racing with input_get_keycode()
> -	 * and input_set_keycode() if we are called while input device
> -	 * is still registered.
> -	 */
> -	spin_lock_irqsave(&dev->event_lock, flags);
> -
> -	kfree(dev->keycode);
> -	dev->keycode = NULL;
> -	dev->keycodemax = 0;
> -
> -	spin_unlock_irqrestore(&dev->event_lock, flags);
>  }
>  EXPORT_SYMBOL(sparse_keymap_free);
>  
> -- 
> 2.12.0
> 

-- 
Dmitry
