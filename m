From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: keyboard: sun4i-lradc-keys: Add of_node_put()
 before return
Date: Thu, 11 Jul 2019 23:50:09 -0700
Message-ID: <20190712065009.GE150689@dtor-ws>
References: <20190709175707.14278-1-nishkadg.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190709175707.14278-1-nishkadg.linux@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc: maxime.ripard@bootlin.com, hdegoede@redhat.com, wens@csie.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 09, 2019 at 11:27:07PM +0530, Nishka Dasgupta wrote:
> Each iteration of for_each_child_of_node puts the previous
> node, but in the case of a return from the middle of the loop, there is
> no put, thus causing a memory leak. Hence add an of_node_put before the
> return in three places.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/sun4i-lradc-keys.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
> index 6ffdc26b9c89..4a796bed48ac 100644
> --- a/drivers/input/keyboard/sun4i-lradc-keys.c
> +++ b/drivers/input/keyboard/sun4i-lradc-keys.c
> @@ -198,18 +198,21 @@ static int sun4i_lradc_load_dt_keymap(struct device *dev,
>  		error = of_property_read_u32(pp, "channel", &channel);
>  		if (error || channel != 0) {
>  			dev_err(dev, "%pOFn: Inval channel prop\n", pp);
> +			of_node_put(pp);
>  			return -EINVAL;
>  		}
>  
>  		error = of_property_read_u32(pp, "voltage", &map->voltage);
>  		if (error) {
>  			dev_err(dev, "%pOFn: Inval voltage prop\n", pp);
> +			of_node_put(pp);
>  			return -EINVAL;
>  		}
>  
>  		error = of_property_read_u32(pp, "linux,code", &map->keycode);
>  		if (error) {
>  			dev_err(dev, "%pOFn: Inval linux,code prop\n", pp);
> +			of_node_put(pp);
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.19.1
> 

-- 
Dmitry
