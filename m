From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 2/7] i2c: i2c-cros-ec-tunnel: Set retries to 3
Date: Fri, 01 Aug 2014 20:05:57 +0200
Message-ID: <53DBD705.2060706@collabora.co.uk>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk> <1406549967-21291-3-git-send-email-javier.martinez@collabora.co.uk> <20140801175912.GF3277@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140801175912.GF3277@katana>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Wolfram,

On 08/01/2014 07:59 PM, Wolfram Sang wrote:
>>  
>> +#define I2C_MAX_RETRIES 3
> 
> I think a define for this is overkill, yet I don't really mind.
>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
>

Thanks a lot.

> I assume this goes via MFD, let me know if I should take it.
> 

Yes, if possible I prefer if all the series are picked by Lee Jones to avoid any
dependencies.

Best regards,
Javier
