From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 8/8] Loongson: YeeLoong: add input/hotkey driver
Date: Fri, 4 Dec 2009 09:14:02 +0100
Message-ID: <20091204081402.GD1540@ucw.cz>
References: <cover.1259932036.git.wuzhangjin@gmail.com> <7e96d37889c49c2d6d284e21773aef90dd3aac25.1259932036.git.wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34555 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbZLDOub (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 09:50:31 -0500
Content-Disposition: inline
In-Reply-To: <7e96d37889c49c2d6d284e21773aef90dd3aac25.1259932036.git.wuzhangjin@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com, linux-laptop@vger.kernel.org, linux-input@vger.kernel.org

Hi!


> +#define NO_REG		0
> +#define NO_HANDLER	NULL

Don't obfuscate code like that.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
