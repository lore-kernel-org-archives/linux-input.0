From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input/keyboard: new OpenCores Keyboard Controller driver
Date: Mon, 14 Sep 2009 10:49:50 -0700
Message-ID: <200909141049.50705.dmitry.torokhov@gmail.com>
References: <1252911864-19233-1-git-send-email-vapier@gentoo.org> <1252950003-9451-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755843AbZINRt7@vger.kernel.org>
In-Reply-To: <1252950003-9451-1-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Herrero <jherrero@hvsistemas.es>, Bryan Wu <cooloney@kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Mike,

On Monday 14 September 2009 10:40:03 am Mike Frysinger wrote:
> +
> +struct opencores_kbd {
> +	struct input_dev *input;
> +	struct resource *addr_res;
> +	struct resource *irq_res;
> +	unsigned short *keycode;
> +};

Why do we allocate keycode table separately form the main structure?

I think I still have some reservations with the notion that we can just
have exact "scancode" - KEY_* mapping and hardware producers will adjust
the hardware to follow the deriver but I guess it's OK...


-- 
Dmitry
