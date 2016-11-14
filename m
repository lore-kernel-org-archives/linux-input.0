From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v9 2/5] iio: adc: mxs-lradc: Add support for adc driver
Date: Mon, 14 Nov 2016 19:46:41 +0100
Message-ID: <ce65afb5-7628-af80-a43b-d73ade71c72a@denx.de>
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
 <c750ee15d03f6cf1a066dda21b1973d74cf9f59f.1478071676.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c750ee15d03f6cf1a066dda21b1973d74cf9f59f.1478071676.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com
List-Id: linux-input@vger.kernel.org

On 11/02/2016 08:38 AM, Ksenija Stanojevic wrote:
> Add support for sixteen-channel 12-bit resolution ADC and its functions,
> which include general-purpose ADC readings, battery voltage measurement,
> and die temperature measurement.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> ---

Shouldn't you squash this and 4/5 , in which case this would result in a
move ?

-- 
Best regards,
Marek Vasut
