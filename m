From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH v7 8/8] Loongson: YeeLoong: add input/hotkey driver
Date: Fri, 04 Dec 2009 22:57:52 +0800
Message-ID: <1259938672.9554.3.camel@falcon.domain.org>
References: <cover.1259932036.git.wuzhangjin@gmail.com>
	 <7e96d37889c49c2d6d284e21773aef90dd3aac25.1259932036.git.wuzhangjin@gmail.com>
	 <20091204081402.GD1540@ucw.cz>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-laptop-owner@vger.kernel.org>
In-Reply-To: <20091204081402.GD1540@ucw.cz>
Sender: linux-laptop-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com, linux-laptop@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2009-12-04 at 09:14 +0100, Pavel Machek wrote:
> Hi!
> 
> 
> > +#define NO_REG		0
> > +#define NO_HANDLER	NULL
> 
> Don't obfuscate code like that.

Will remove it later, thanks!


