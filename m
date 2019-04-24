From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] input: edt-ft5x06 - Call devm_of_device_links_add()
 to create links
Date: Wed, 24 Apr 2019 15:52:35 -0700
Message-ID: <20190424225235.GA225055@dtor-ws>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
 <20190424101913.1534-4-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424101913.1534-4-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: rafael.j.wysocki@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, hadess@hadess.net, frowand.list@gmail.com, m.felsch@pengutronix.de, agx@sigxcpu.org, yannick.fertre@st.com, arnd@arndb.de, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On Wed, Apr 24, 2019 at 12:19:11PM +0200, Benjamin Gaignard wrote:
> From: Yannick FertrÃ© <yannick.fertre@st.com>
> 
> Add a call to devm_of_device_links_add() to create links with suppliers
> at probe time.
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 702bfda7ee77..ac9f7e85efb0 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1167,6 +1167,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, tsdata);
>  
> +	devm_of_device_links_add(&client->dev);
> +

This seems pretty generic action and I believe it should be done in
generic code, either bus (i2c, spi, etc), or in device core.

Thanks.

-- 
Dmitry
