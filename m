From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] Input: synaptics-rmi4 - Propagate correct number
 of rx and tx electrodes to F54
Date: Tue, 22 Nov 2016 17:58:25 -0800
Message-ID: <20161123015825.GF21078@dtor-ws>
References: <1479188378-19379-1-git-send-email-linux@roeck-us.net>
 <1479188378-19379-2-git-send-email-linux@roeck-us.net>
 <20161115223838.GB19433@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161115223838.GB19433@lava.h.shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Nov 15, 2016 at 10:38:38PM +0000, Nick Dyer wrote:
> On Mon, Nov 14, 2016 at 09:39:38PM -0800, Guenter Roeck wrote:
> > F54 diagnostics report functions provide data based on the number of
> > enabled rx and tx electrodes, which is not identical to the number of
> > electrodes reported with F54:Query0 and F54:Query1. Those values report
> > the number of supported electrodes, not the number of enabled electrodes.
> > The number of enabled electrodes can be determined by analyzing F55:Ctrl1
> > (sensor receiver assignment) and F55:Ctrl2 (sensor transmitter assignment).
> > 
> > Propagate the number of enabled electrodes from F55 to F54 to avoid
> > corrupted output if not all electrodes are enabled.
> > 
> > Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 ...")
> > Cc: Nick Dyer <nick@shmanahar.org>
> > Cc: Andrew Duggan <aduggan@synaptics.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Tested-by: Nick Dyer <nick@shmanahar.org>

Applied, thank you.

> 
> > ---
> > v2: Update Fixes: sha
> > 
> >  drivers/input/rmi4/Kconfig   |  1 +
> >  drivers/input/rmi4/rmi_f54.c | 14 ++++++++++----
> >  drivers/input/rmi4/rmi_f55.c |  7 +++++++
> >  include/linux/rmi.h          |  3 +++
> >  4 files changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> > index 11ede43c9936..d7129928cde6 100644
> > --- a/drivers/input/rmi4/Kconfig
> > +++ b/drivers/input/rmi4/Kconfig
> > @@ -67,6 +67,7 @@ config RMI4_F54
> >  	depends on RMI4_CORE
> >  	depends on VIDEO_V4L2=y || (RMI4_CORE=m && VIDEO_V4L2=m)
> >  	select VIDEOBUF2_VMALLOC
> > +	select RMI4_F55
> >  	help
> >  	  Say Y here if you want to add support for RMI4 function 54
> >  
> > diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> > index cf805b960866..9cb3aa733f0f 100644
> > --- a/drivers/input/rmi4/rmi_f54.c
> > +++ b/drivers/input/rmi4/rmi_f54.c
> > @@ -216,8 +216,10 @@ static int rmi_f54_request_report(struct rmi_function *fn, u8 report_type)
> >  
> >  static size_t rmi_f54_get_report_size(struct f54_data *f54)
> >  {
> > -	u8 rx = f54->num_rx_electrodes ? : f54->num_rx_electrodes;
> > -	u8 tx = f54->num_tx_electrodes ? : f54->num_tx_electrodes;
> > +	struct rmi_device *rmi_dev = f54->fn->rmi_dev;
> > +	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
> > +	u8 rx = drv_data->num_rx_electrodes ? : f54->num_rx_electrodes;
> > +	u8 tx = drv_data->num_tx_electrodes ? : f54->num_tx_electrodes;
> >  	size_t size;
> >  
> >  	switch (rmi_f54_get_reptype(f54, f54->input)) {
> > @@ -401,6 +403,10 @@ static int rmi_f54_vidioc_enum_input(struct file *file, void *priv,
> >  
> >  static int rmi_f54_set_input(struct f54_data *f54, unsigned int i)
> >  {
> > +	struct rmi_device *rmi_dev = f54->fn->rmi_dev;
> > +	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
> > +	u8 rx = drv_data->num_rx_electrodes ? : f54->num_rx_electrodes;
> > +	u8 tx = drv_data->num_tx_electrodes ? : f54->num_tx_electrodes;
> >  	struct v4l2_pix_format *f = &f54->format;
> >  	enum rmi_f54_report_type reptype;
> >  	int ret;
> > @@ -415,8 +421,8 @@ static int rmi_f54_set_input(struct f54_data *f54, unsigned int i)
> >  
> >  	f54->input = i;
> >  
> > -	f->width = f54->num_rx_electrodes;
> > -	f->height = f54->num_tx_electrodes;
> > +	f->width = rx;
> > +	f->height = tx;
> >  	f->field = V4L2_FIELD_NONE;
> >  	f->colorspace = V4L2_COLORSPACE_RAW;
> >  	f->bytesperline = f->width * sizeof(u16);
> > diff --git a/drivers/input/rmi4/rmi_f55.c b/drivers/input/rmi4/rmi_f55.c
> > index 2d221cc97391..37390ca6a924 100644
> > --- a/drivers/input/rmi4/rmi_f55.c
> > +++ b/drivers/input/rmi4/rmi_f55.c
> > @@ -38,6 +38,8 @@ struct f55_data {
> >  
> >  static int rmi_f55_detect(struct rmi_function *fn)
> >  {
> > +	struct rmi_device *rmi_dev = fn->rmi_dev;
> > +	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
> >  	struct f55_data *f55;
> >  	int error;
> >  
> > @@ -57,6 +59,9 @@ static int rmi_f55_detect(struct rmi_function *fn)
> >  	f55->cfg_num_rx_electrodes = f55->num_rx_electrodes;
> >  	f55->cfg_num_tx_electrodes = f55->num_rx_electrodes;
> >  
> > +	drv_data->num_rx_electrodes = f55->cfg_num_rx_electrodes;
> > +	drv_data->num_tx_electrodes = f55->cfg_num_rx_electrodes;
> > +
> >  	if (f55->qry[F55_PHYS_CHAR_OFFSET] & F55_CAP_SENSOR_ASSIGN) {
> >  		int i, total;
> >  		u8 buf[256];
> > @@ -78,6 +83,7 @@ static int rmi_f55_detect(struct rmi_function *fn)
> >  					total++;
> >  			}
> >  			f55->cfg_num_rx_electrodes = total;
> > +			drv_data->num_rx_electrodes = total;
> >  		}
> >  
> >  		error = rmi_read_block(fn->rmi_dev,
> > @@ -90,6 +96,7 @@ static int rmi_f55_detect(struct rmi_function *fn)
> >  					total++;
> >  			}
> >  			f55->cfg_num_tx_electrodes = total;
> > +			drv_data->num_tx_electrodes = total;
> >  		}
> >  	}
> >  
> > diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> > index e0aca1476001..45734f1343b3 100644
> > --- a/include/linux/rmi.h
> > +++ b/include/linux/rmi.h
> > @@ -345,6 +345,9 @@ struct rmi_driver_data {
> >  	u8 pdt_props;
> >  	u8 bsr;
> >  
> > +	u8 num_rx_electrodes;
> > +	u8 num_tx_electrodes;
> > +
> >  	bool enabled;
> >  
> >  	void *data;
> > -- 
> > 2.5.0
> > 

-- 
Dmitry
