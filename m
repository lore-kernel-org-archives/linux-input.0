From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers: input: Add SPDX-License-Identifier
Date: Wed, 18 Jul 2018 16:13:55 +0000
Message-ID: <20180718161355.o7nct5jcxh4xqmgz@penguin>
References: <1530879112-3388-1-git-send-email-christian.thoms93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530879112-3388-1-git-send-email-christian.thoms93@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Thoms <christian.thoms93@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de, Sebastian Hillert <sebastian.hillert1@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Christian,

On Fri, Jul 06, 2018 at 02:11:52PM +0200, Christian Thoms wrote:
> diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> index 66a46c8..3086166 100644
> --- a/drivers/input/ff-core.c
> +++ b/drivers/input/ff-core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *  Force feedback support for Linux input subsystem
>   *
> @@ -6,11 +7,6 @@
>   */
>  
>  /*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
>   * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

Why did you keep this block here? Also, below, there is another
paragraph about obtaining a copy of GPL from an old FSF address. If we
are cleaning it I believe it all needs to go.

I see the similar issue in several other files in this patch.

Thanks.

-- 
Dmitry
