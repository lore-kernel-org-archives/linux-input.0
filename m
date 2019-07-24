From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - mark expected switch fall-through
Date: Wed, 24 Jul 2019 22:25:28 +0300
Message-ID: <20190724192528.GA6859@penguin>
References: <20190724175202.GA9583@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190724175202.GA9583@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Gustavo,

On Wed, Jul 24, 2019 at 12:52:02PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/input/mouse/elantech.c: In function 'elantech_use_host_notify':
> drivers/input/mouse/elantech.c:1843:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (dmi_get_bios_year() >= 2018)
>       ^
> drivers/input/mouse/elantech.c:1845:2: note: here
>   default:
>   ^~~~~~~

Thank you for the patch but I already pushed out similar patch.

Thanks.

-- 
Dmitry
