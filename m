From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: touchscreen: Fix coding style issue
Date: Fri, 21 Dec 2018 01:07:33 -0800
Message-ID: <20181221090733.GL211587@dtor-ws>
References: <20181211111740.25643-1-hardiksingh.k@gmail.com>
 <20181211130332.27781-1-hardiksingh.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211130332.27781-1-hardiksingh.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hardik Singh Rathore <hardiksingh.k@gmail.com>
Cc: michael.hennerich@analog.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com
List-Id: linux-input@vger.kernel.org

On Tue, Dec 11, 2018 at 06:33:32PM +0530, Hardik Singh Rathore wrote:
> This patch fixes the coding style problem reported
> by checkpatch.pl as below:
> 
> ERROR: foo* bar should be "foo *bar"
> 
> Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>

Applied, thank you.

> ---
> v3:
> - v2 was depends on v1 so it didn't solve the issue.
> 
>  drivers/input/touchscreen/ad7879.c   | 2 +-
>  drivers/input/touchscreen/ektf2127.c | 2 +-
>  drivers/input/touchscreen/gunze.c    | 4 ++--
>  drivers/input/touchscreen/inexio.c   | 4 ++--
>  drivers/input/touchscreen/mtouch.c   | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 6bad23ee47a1..b68902c17f2e 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -290,7 +290,7 @@ static int ad7879_open(struct input_dev *input)
>  	return 0;
>  }
>  
> -static void ad7879_close(struct input_dev* input)
> +static void ad7879_close(struct input_dev *input)
>  {
>  	struct ad7879 *ts = input_get_drvdata(input);
>  
> diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
> index 0ed34ff787ce..28fa1b36f7a5 100644
> --- a/drivers/input/touchscreen/ektf2127.c
> +++ b/drivers/input/touchscreen/ektf2127.c
> @@ -51,7 +51,7 @@ struct ektf2127_ts {
>  	struct touchscreen_properties prop;
>  };
>  
> -static void ektf2127_parse_coordinates(const u8* buf, unsigned int touch_count,
> +static void ektf2127_parse_coordinates(const u8 *buf, unsigned int touch_count,
>  				       struct input_mt_pos *touches)
>  {
>  	int index = 0;
> diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
> index 054c2537b392..56cf1a1ea3ea 100644
> --- a/drivers/input/touchscreen/gunze.c
> +++ b/drivers/input/touchscreen/gunze.c
> @@ -53,7 +53,7 @@ struct gunze {
>  	char phys[32];
>  };
>  
> -static void gunze_process_packet(struct gunze* gunze)
> +static void gunze_process_packet(struct gunze *gunze)
>  {
>  	struct input_dev *dev = gunze->dev;
>  
> @@ -72,7 +72,7 @@ static void gunze_process_packet(struct gunze* gunze)
>  static irqreturn_t gunze_interrupt(struct serio *serio,
>  		unsigned char data, unsigned int flags)
>  {
> -	struct gunze* gunze = serio_get_drvdata(serio);
> +	struct gunze *gunze = serio_get_drvdata(serio);
>  
>  	if (data == '\r') {
>  		gunze_process_packet(gunze);
> diff --git a/drivers/input/touchscreen/inexio.c b/drivers/input/touchscreen/inexio.c
> index b9bc56233ccc..13bd0bf580a7 100644
> --- a/drivers/input/touchscreen/inexio.c
> +++ b/drivers/input/touchscreen/inexio.c
> @@ -79,7 +79,7 @@ static void inexio_process_data(struct inexio *pinexio)
>  static irqreturn_t inexio_interrupt(struct serio *serio,
>  		unsigned char data, unsigned int flags)
>  {
> -	struct inexio* pinexio = serio_get_drvdata(serio);
> +	struct inexio *pinexio = serio_get_drvdata(serio);
>  
>  	pinexio->data[pinexio->idx] = data;
>  
> @@ -97,7 +97,7 @@ static irqreturn_t inexio_interrupt(struct serio *serio,
>  
>  static void inexio_disconnect(struct serio *serio)
>  {
> -	struct inexio* pinexio = serio_get_drvdata(serio);
> +	struct inexio *pinexio = serio_get_drvdata(serio);
>  
>  	input_get_device(pinexio->dev);
>  	input_unregister_device(pinexio->dev);
> diff --git a/drivers/input/touchscreen/mtouch.c b/drivers/input/touchscreen/mtouch.c
> index a3707fad4d1c..8278a9058640 100644
> --- a/drivers/input/touchscreen/mtouch.c
> +++ b/drivers/input/touchscreen/mtouch.c
> @@ -90,7 +90,7 @@ static void mtouch_process_response(struct mtouch *mtouch)
>  static irqreturn_t mtouch_interrupt(struct serio *serio,
>  		unsigned char data, unsigned int flags)
>  {
> -	struct mtouch* mtouch = serio_get_drvdata(serio);
> +	struct mtouch *mtouch = serio_get_drvdata(serio);
>  
>  	mtouch->data[mtouch->idx] = data;
>  
> @@ -110,7 +110,7 @@ static irqreturn_t mtouch_interrupt(struct serio *serio,
>  
>  static void mtouch_disconnect(struct serio *serio)
>  {
> -	struct mtouch* mtouch = serio_get_drvdata(serio);
> +	struct mtouch *mtouch = serio_get_drvdata(serio);
>  
>  	input_get_device(mtouch->dev);
>  	input_unregister_device(mtouch->dev);
> -- 
> 2.17.1
> 

-- 
Dmitry
