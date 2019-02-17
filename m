From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1] Input: st-keyscan - fix potential zalloc NULL
 dereference
Date: Sat, 16 Feb 2019 21:26:34 -0800
Message-ID: <20190217052634.GA107793@dtor-ws>
References: <20190212153055.3925-1-gabriel.fernandez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212153055.3925-1-gabriel.fernandez@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gabriel.fernandez@st.com
Cc: linux-clk@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, giuseppe.condorelli@st.com, Nate Drude <nate.drude@ohmlinxelectronics.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-input@vger.kernel.org

On Tue, Feb 12, 2019 at 04:30:55PM +0100, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch fixes the following static checker warning:
> 
> drivers/input/keyboard/st-keyscan.c:156 keyscan_probe()
> error: potential zalloc NULL dereference: 'keypad_data->input_dev'
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/st-keyscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
> index babcfb165e4f..3b85631fde91 100644
> --- a/drivers/input/keyboard/st-keyscan.c
> +++ b/drivers/input/keyboard/st-keyscan.c
> @@ -153,6 +153,8 @@ static int keyscan_probe(struct platform_device *pdev)
>  
>  	input_dev->id.bustype = BUS_HOST;
>  
> +	keypad_data->input_dev = input_dev;
> +
>  	error = keypad_matrix_key_parse_dt(keypad_data);
>  	if (error)
>  		return error;
> @@ -168,8 +170,6 @@ static int keyscan_probe(struct platform_device *pdev)
>  
>  	input_set_drvdata(input_dev, keypad_data);
>  
> -	keypad_data->input_dev = input_dev;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	keypad_data->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(keypad_data->base))
> -- 
> 2.17.0
> 

-- 
Dmitry
