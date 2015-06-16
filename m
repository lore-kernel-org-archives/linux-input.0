From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 11/17] drivers/input/gameport: Replace rdtscl() with
 native_read_tsc()
Date: Tue, 16 Jun 2015 16:04:25 -0700
Message-ID: <20150616230425.GD17610@dtor-ws>
References: <cover.1434152603.git.luto@kernel.org>
 <1937af4905bc041d07d05bc51bca983a60df2c6c.1434152603.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33578 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbbFPXEa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 19:04:30 -0400
Content-Disposition: inline
In-Reply-To: <1937af4905bc041d07d05bc51bca983a60df2c6c.1434152603.git.luto@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>, Denys Vlasenko <dvlasenk@redhat.com>, linux-input@vger.kernel.org

On Fri, Jun 12, 2015 at 04:44:51PM -0700, Andy Lutomirski wrote:
> It's unclear to me why this code exists in the first place.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/gameport/gameport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
> index e853a2134680..abc0cb22e750 100644
> --- a/drivers/input/gameport/gameport.c
> +++ b/drivers/input/gameport/gameport.c
> @@ -149,9 +149,9 @@ static int old_gameport_measure_speed(struct gameport *gameport)
>  
>  	for(i = 0; i < 50; i++) {
>  		local_irq_save(flags);
> -		rdtscl(t1);
> +		t1 = native_read_tsc();
>  		for (t = 0; t < 50; t++) gameport_read(gameport);
> -		rdtscl(t2);
> +		t2 = native_read_tsc();
>  		local_irq_restore(flags);
>  		udelay(i * 10);
>  		if (t2 - t1 < tx) tx = t2 - t1;
> -- 
> 2.4.2
> 

-- 
Dmitry
