From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: mms114: Use devm_* APIs
Date: Tue, 8 Jan 2013 09:25:29 -0800
Message-ID: <20130108172529.GA6746@core.coreip.homeip.net>
References: <1357639508-15645-1-git-send-email-sachin.kamat@linaro.org>
 <50EBFE23.7070401@nvidia.com>
 <CAK9yfHyAnb02mBGVJuaJ9YZdKZox6vqwE0pNEmxRdAhUOOn0Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49272 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893Ab3AHSOe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jan 2013 13:14:34 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so482828pad.11
        for <linux-input@vger.kernel.org>; Tue, 08 Jan 2013 10:14:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAK9yfHyAnb02mBGVJuaJ9YZdKZox6vqwE0pNEmxRdAhUOOn0Fw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "patches@linaro.org" <patche@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>

Hi Sachin,

On Tue, Jan 08, 2013 at 05:08:12PM +0530, Sachin Kamat wrote:
> Hi Laxman,
> 
> Thank you for your suggestion.
> 
> On 8 January 2013 16:38, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> > On Tuesday 08 January 2013 03:35 PM, Sachin Kamat wrote:
> >>
> >> devm_* APIs are device managed and make the exit and clean up code
> >> simpler.
> >>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> >> ---
> >> Compile tested against linux-next tree (20130108).
> >> ---
> >>   drivers/input/touchscreen/mms114.c |   41
> >> +++++++++++------------------------
> >>   1 files changed, 13 insertions(+), 28 deletions(-)
> >
> >
> >>   static int mms114_remove(struct i2c_client *client)
> >>   {
> >>         struct mms114_data *data = i2c_get_clientdata(client);
> >>   -     free_irq(client->irq, data);
> >> -       regulator_put(data->io_reg);
> >> -       regulator_put(data->core_reg);
> >>         input_unregister_device(data->input_dev);
> >
> >
> > Because you are using devm_input_allocate_device() for allocating input
> > device, you need not to have the input_unregister_device() and so you can
> > get rid of remove() callback at all.
> > This is what I learnt from Dmitry on similar patch for Tegra KBC.
> 
> input_free_device() is the one which is not required when you use
> devm_input_allocate_device().
> Unregister call, AFAIK, is required since we are registering using
> input_register_device().
> 
> Dmitry, please let me know if my understanding is right.

Laxman is correct, neither of the calls is normally needed for managed
input devices. I am considering applying the patch below clarifying this
fact.

Thanks.

-- 
Dmitry


Input: document that unregistering managed devices is not necessary

Apparently some users of managed input devices are confused whether
input_unregister_device() is needed when working with them. Clarify
this in the kernel doc for devm_input_allocate_device(): in most cases
there is no need to call either input_unregister_device() nor
input_free_device() when working with managed devices.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index ce01332f..c044699 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1785,12 +1785,13 @@ static void devm_input_device_release(struct device *dev, void *res)
  * its driver (or binding fails). Once managed input device is allocated,
  * it is ready to be set up and registered in the same fashion as regular
  * input device. There are no special devm_input_device_[un]register()
- * variants, regular ones work with both managed and unmanaged devices.
+ * variants, regular ones work with both managed and unmanaged devices,
+ * should you need them. In most cases however, managed input device need
+ * not be explicitly unregistered or freed.
  *
  * NOTE: the owner device is set up as parent of input device and users
  * should not override it.
  */
-
 struct input_dev *devm_input_allocate_device(struct device *dev)
 {
 	struct input_dev *input;
@@ -2004,6 +2005,17 @@ static void devm_input_device_unregister(struct device *dev, void *res)
  * Once device has been successfully registered it can be unregistered
  * with input_unregister_device(); input_free_device() should not be
  * called in this case.
+ *
+ * Note that this function is also used to register managed input devices
+ * (ones allocated with devm_input_allocate_device()). Such managed input
+ * devices need not be explicitly unregistered or freed, their tear down
+ * is controlled by the devres infrastructure. It is also worth noting
+ * that tear down of managed input devices is internally a 2-step process:
+ * registered managed input device is first unregistered, but stays in
+ * memory and can still handle input_event() calls (although events will
+ * not be delivered anywhere). The freeing of managed input device will
+ * happen later, when devres stack is unwound to the point where device
+ * allocation was made.
  */
 int input_register_device(struct input_dev *dev)
 {
