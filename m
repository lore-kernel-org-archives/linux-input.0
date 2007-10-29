From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] INPUT: fix hidinput_connect ignoring retval from input_register_device
Date: Mon, 29 Oct 2007 03:53:14 -0400
Message-ID: <4725916A.7010505@garzik.org>
References: <20071029065153.GA9490@bigserver.hohndel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754583AbXJ2Hx3@vger.kernel.org>
In-Reply-To: <20071029065153.GA9490@bigserver.hohndel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dirk Hohndel <hohndel@linux.intel.com>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dirk Hohndel wrote:
> [INPUT] hidinput_connect incorrectly ignored return value from input_register_device
> 
> Signed-off-by: Dirk Hohndel <hohndel@linux.intel.com>
> 
> ---
>  drivers/hid/hid-input.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index dd332f2..c8640e7 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1186,13 +1186,19 @@ int hidinput_connect(struct hid_device *hid)
>  				 * UGCI) cram a lot of unrelated inputs into the
>  				 * same interface. */
>  				hidinput->report = report;
> -				input_register_device(hidinput->input);
> +				if (input_register_device(hidinput->input)) {
> +					input_free_device(hidinput->input);
> +					return -1;
> +				}
>  				hidinput = NULL;
>  			}
>  		}
>  
>  	if (hidinput)
> -		input_register_device(hidinput->input);
> +		if (input_register_device(hidinput->input)) {
> +			input_free_device(hidinput->input);
> +			return -1;
> +		}

You would also want to kfree(hidinput) on failure too.

Thanks for attacking this newly added warning!

	Jeff
