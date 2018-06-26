From: cgxu519 <cgxu519@gmx.com>
Subject: Re: [PATCH v2 net] nfp: cast sizeof() to int when comparing with
 error code
Date: Tue, 26 Jun 2018 16:21:10 +0800
Message-ID: <a119eba4-aeb5-c8ee-ff48-07ee566d8431@gmx.com>
References: <20180626011631.22717-1-cgxu519@gmx.com>
 <ff0b2834b771a467246b9f7c1b4600c38f5bb463.camel@perches.com>
 <alpine.DEB.2.20.1806261005190.4512@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1806261005190.4512@hadrien>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Joe Perches <joe@perches.com>, jakub.kicinski@netronome.com, davem@davemloft.net, LKML <linux-kernel@vger.kernel.org>, cocci <cocci@systeme.lip6.fr>, oss-drivers@netronome.com, netdev@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 06/26/2018 04:06 PM, Julia Lawall wrote:
>
> On Mon, 25 Jun 2018, Joe Perches wrote:
>
>> On Tue, 2018-06-26 at 09:16 +0800, Chengguang Xu wrote:
>>> sizeof() will return unsigned value so in the error check
>>> negative error code will be always larger than sizeof().
>> This looks like a general class of error in the kernel
>> where a signed result that could be returning a -errno
>> is tested against < or <= sizeof()
>>
>> A couple examples:
>>
>> drivers/input/mouse/elan_i2c_smbus.c:
>>
>> 		len = i2c_smbus_read_block_data(client,
>> 						ETP_SMBUS_IAP_PASSWORD_READ,
>> 						val);
>> 		if (len < sizeof(u16)) {
>>
>> i2c_smbus_read_block_data can return a negative errno
>>
>>
>> net/smc/smc_clc.c:
>>
>> 	len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
>> 			     sizeof(struct smc_clc_msg_decline));
>> 	if (len < sizeof(struct smc_clc_msg_decline))
>>
>> where kernel_sendmsg can return a negative errno
>>
>> There are probably others, I didn't look hard.
>>
>> Perhaps a cocci script to find these could be generated?
> Here's another one:
>
> drivers/usb/serial/ir-usb.c
> @@ -126,13 +126,8 @@ irda_usb_find_class_desc(struct usb_seri
>   	if (!desc)
>   		return NULL;
>
> -	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
> -			USB_REQ_CS_IRDA_GET_CLASS_DESC,
> -			USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> -			0, ifnum, desc, sizeof(*desc), 1000);
>
>   	dev_dbg(&serial->dev->dev, "%s -  ret=%d\n", __func__, ret);
> -	if (ret < sizeof(*desc)) {
>   		dev_dbg(&serial->dev->dev,
>   			"%s - class descriptor read %s (%d)\n", __func__,
>   			(ret < 0) ? "failed" : "too short", ret);
>
> There are other results, but I haven't checked all of them.

Hi Julia,

Thanks for your check. I posted a patch yesterday to fix three places in 
usb subsystem
and the patch is just in queue now, so you can skip these places.

The detail of patch.
---

diff --git a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
index 24b06c7e5e2d..7643716b5299 100644
--- a/drivers/usb/serial/ir-usb.c
+++ b/drivers/usb/serial/ir-usb.c
@@ -132,7 +132,7 @@ irda_usb_find_class_desc(struct usb_serial *serial, unsigned int ifnum)
  			0, ifnum, desc, sizeof(*desc), 1000);
  
  	dev_dbg(&serial->dev->dev, "%s -  ret=%d\n", __func__, ret);
-	if (ret < sizeof(*desc)) {
+	if (ret < (int)sizeof(*desc)) {
  		dev_dbg(&serial->dev->dev,
  			"%s - class descriptor read %s (%d)\n", __func__,
  			(ret < 0) ? "failed" : "too short", ret);
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 958e12e1e7c7..ff2322ea5e14 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -194,7 +194,7 @@ static inline int qt2_getregister(struct usb_device *dev,
  	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
  			      QT_SET_GET_REGISTER, 0xc0, reg,
  			      uart, data, sizeof(*data), QT2_USB_TIMEOUT);
-	if (ret < sizeof(*data)) {
+	if (ret < (int)sizeof(*data)) {
  		if (ret >= 0)
  			ret = -EIO;
  	}
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 2083c267787b..0900b47b5f57 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -104,7 +104,7 @@ static inline int ssu100_getregister(struct usb_device *dev,
  	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
  			      QT_SET_GET_REGISTER, 0xc0, reg,
  			      uart, data, sizeof(*data), 300);
-	if (ret < sizeof(*data)) {
+	if (ret < (int)sizeof(*data)) {
  		if (ret >= 0)
  			ret = -EIO;
  	}
---




Thanks,
Chengguang.
