From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Mon, 9 May 2011 19:06:19 +0100
Message-ID: <20110509180619.GA8563@srcf.ucam.org>
References: <20110407181800.27b441b1@destiny.ordissimo>
 <20110509143828.GA2632@srcf.ucam.org>
 <4DC80A53.7050609@windriver.com>
 <20110509154729.GA5043@srcf.ucam.org>
 <4DC80F45.2040508@windriver.com>
 <20110509164006.GA6570@srcf.ucam.org>
 <20110509195802.0389639d@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110509195802.0389639d@destiny.ordissimo>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: Andy Ross <andy.ross@windriver.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Corentin Chary <corentin.chary@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, May 09, 2011 at 07:58:02PM +0200, Anisse Astier wrote:

> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index 2105b42..e23d555 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -1337,6 +1337,13 @@ static void asus_acpi_notify(struct acpi_device *device, u32 event)
>  		}
>  		return ;
>  	}
> +
> +	/* Accelerometer "coarse orientation change" event */
> +	if (asus->pega_accel && event == 0xEA) {
> +		kobject_uevent(&asus->pega_accel->dev.kobj, KOBJ_CHANGE);
> +		return ;
> +	}
> +
>  	asus_input_notify(asus, event);
>  }

Precisely that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
