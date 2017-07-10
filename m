From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] input: tegra-kbc: add NULL check on of_match_device()
 return value
Date: Mon, 10 Jul 2017 14:27:53 -0500
Message-ID: <20170710142753.Horde.MbnV4VVjMQGQTwFb4achCEe@gator4166.hostgator.com>
References: <20170707062758.GA17584@embeddedgus>
 <ec9b399b-ad14-21eb-9a2e-649f0dd1d489@nvidia.com>
 <20170707093041.GC15652@ulmo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707093041.GC15652@ulmo.fritz.box>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi all,

Quoting Thierry Reding <thierry.reding@gmail.com>:

> On Fri, Jul 07, 2017 at 08:42:32AM +0100, Jon Hunter wrote:
>>
>> On 07/07/17 07:27, Gustavo A. R. Silva wrote:
>> > Check return value from call to of_match_device()
>> > in order to prevent a NULL pointer dereference.
>> >
>> > In case of NULL print error message and return -ENODEV
>> >
>> > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> > ---
>> >  drivers/input/keyboard/tegra-kbc.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/drivers/input/keyboard/tegra-kbc.c  
>> b/drivers/input/keyboard/tegra-kbc.c
>> > index 0c07e10..742c5ac 100644
>> > --- a/drivers/input/keyboard/tegra-kbc.c
>> > +++ b/drivers/input/keyboard/tegra-kbc.c
>> > @@ -617,6 +617,10 @@ static int tegra_kbc_probe(struct  
>> platform_device *pdev)
>> >  	const struct of_device_id *match;
>> >
>> >  	match = of_match_device(tegra_kbc_of_match, &pdev->dev);
>> > +	if (!match) {
>> > +		dev_err(&pdev->dev, "failed to match device\n");
>> > +		return -ENODEV;
>> > +	}
>>
>> Given that Tegra always uses device-tree, I believe that this cannot
>> happen and so this additional check is not needed.
>
> I think you can make it happen if you manually create the platform
> device with a name matching that of the driver. But you really shouldn't
> be doing that, so might as well let it crash and burn so that people
> realize their mistake early.
>
> Errors are easily overlooked, crashes are not.
>

I get it.

Thanks for clarifying.
--
Gustavo A. R. Silva
