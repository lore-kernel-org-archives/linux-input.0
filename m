From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] HID: debug: improve hid_debug_event()
Date: Wed, 25 Nov 2015 12:31:56 -0800
Message-ID: <1448483516.20113.61.camel@perches.com>
References: <1448368427-1669-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448368427-1669-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2015-11-24 at 13:33 +0100, Rasmus Villemoes wrote:
> The code in hid_debug_event() causes horrible code generation. First,
> we do a strlen() call for every byte we copy (we're doing a store to
> global memory, so gcc has no way of proving that strlen(buf) doesn't
> change). Second, since both i, list->tail and HID_DEBUG_BUFSIZE have
> signed type, the modulo computation has to take into account the
> possibility that list->tail+i is negative, so it's not just a simple
> and.
> 
> Fix the former by simply not doing strlen() at all (we have to load
> buf[i] anyway, so testing it is almost free) and the latter by
> changing i to unsigned. This cuts 29% (69 bytes) of the size of the
> function.
[]
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
[]
> @@ -659,13 +659,13 @@ EXPORT_SYMBOL_GPL(hid_dump_device);
>  /* enqueue string to 'events' ring buffer */
>  void hid_debug_event(struct hid_device *hdev, char *buf)
>  {
> -	int i;
> +	unsigned i;
>  	struct hid_debug_list *list;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&hdev->debug_list_lock, flags);
>  	list_for_each_entry(list, &hdev->debug_list, node) {
> -		for (i = 0; i < strlen(buf); i++)
> +		for (i = 0; buf[i]; i++)
>  			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
>  				buf[i];
>  		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;

trivia:

The code might look nicer if (list->tail + i) % HID_DEBUG_BUFSIZE
was stored into a temporary.

Maybe use an if >= BUFSIZE to avoid a %
Something like:

		int pos = list->tail;
		for (i = 0; buf[i]; i++) {
			list->hid_debug_buf[pos++] = buf[i];
			if (pos >= HID_DEBUG_BUFSIZE)
				pos = 0;
		}
		list->tail = pos;
