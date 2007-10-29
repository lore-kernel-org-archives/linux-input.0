From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] INPUT: fix hidinput_connect ignoring retval from input_register_device
Date: Mon, 29 Oct 2007 05:35:04 -0400
Message-ID: <4725A948.7030603@garzik.org>
References: <20071029084917.GA12968@bigserver.hohndel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071029084917.GA12968@bigserver.hohndel.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dirk Hohndel <hohndel@linux.intel.com>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

Dirk Hohndel wrote:
> [INPUT] hidinput_connect incorrectly ignored return value from input_register_device
> 
> Signed-off-by: Dirk Hohndel <hohndel@linux.intel.com>
> 
> ---
>  drivers/hid/hid-input.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index dd332f2..880161b 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1186,13 +1186,21 @@ int hidinput_connect(struct hid_device *hid)
>  				 * UGCI) cram a lot of unrelated inputs into the
>  				 * same interface. */
>  				hidinput->report = report;
> -				input_register_device(hidinput->input);
> +				if (input_register_device(hidinput->input)) {
> +					input_free_device(hidinput->input);
> +					kfree(hidinput);
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
> +			kfree(hidinput);
> +			return -1;

ACK, thanks for revising
