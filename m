From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c-hid: remove mostly useless parameter 'debug'
Date: Fri, 02 Aug 2013 17:49:47 +0300
Message-ID: <1375454987.31118.77.camel@smile>
References: <1375441636-12921-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1375441636-12921-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <CAN+gG=Ec=jJy7HxRW08up+=Z8C0Lz4B8bhPcP+7__zuONnCAgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54978 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab3HBOuC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Aug 2013 10:50:02 -0400
In-Reply-To: <CAN+gG=Ec=jJy7HxRW08up+=Z8C0Lz4B8bhPcP+7__zuONnCAgw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Fri, 2013-08-02 at 16:30 +0200, Benjamin Tissoires wrote: 
> On Fri, Aug 2, 2013 at 1:07 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > We have nice dynamic debug framework to enable or disable debug messaging at
> > run time. So, instead of an additional module parameter let's use that framework
> > and call dev_dbg() unconditionally in the driver.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> 
> Well, when I introduced those debug variables, I had in mind the fact
> that the driver was not widely tested, and that I may need to ask for
> traces from users. I'm afraid that relying on dev_dbg will create a
> lot more noise when we will want to understand the HID/i2c problems.

You have only those messages on the debug level (frankly, only one is
outside of if (debug) condition).


> Moreover, the dev_dbg calls are compiled out if DEBUG symbol is not
> set.

Yes, and what is the difference between previously used
if (debug)
  dev_dbg(...)

?


> So, if we ever have to change this debug variable, I would prefer
> using the hid debug environment which would at least limit the number
> of debug outputs to the HID subsystem.

Usually when I see such code I understood it was written in
pre-dynamic-debug epoch. So, my point is to switch to dynamic debug and
use it efficiently.

> 
> Cheers,
> Benjamin
> 
> >  drivers/hid/i2c-hid/i2c-hid.c | 59 ++++++++++++++++++-------------------------
> >  1 file changed, 24 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index 05d4f96..5f50fc7 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -47,17 +47,6 @@
> >  #define I2C_HID_PWR_ON         0x00
> >  #define I2C_HID_PWR_SLEEP      0x01
> >
> > -/* debug option */
> > -static bool debug;
> > -module_param(debug, bool, 0444);
> > -MODULE_PARM_DESC(debug, "print a lot of debug information");
> > -
> > -#define i2c_hid_dbg(ihid, fmt, arg...)                                   \
> > -do {                                                                     \
> > -       if (debug)                                                        \
> > -               dev_printk(KERN_DEBUG, &(ihid)->client->dev, fmt, ##arg); \
> > -} while (0)
> > -
> >  struct i2c_hid_desc {
> >         __le16 wHIDDescLength;
> >         __le16 bcdVersion;
> > @@ -177,7 +166,7 @@ static int __i2c_hid_command(struct i2c_client *client,
> >         memcpy(cmd->data + length, args, args_len);
> >         length += args_len;
> >
> > -       i2c_hid_dbg(ihid, "%s: cmd=%*ph\n", __func__, length, cmd->data);
> > +       dev_dbg(&client->dev, "%s: cmd=%*ph\n", __func__, length, cmd->data);
> >
> >         msg[0].addr = client->addr;
> >         msg[0].flags = client->flags & I2C_M_TEN;
> > @@ -207,12 +196,12 @@ static int __i2c_hid_command(struct i2c_client *client,
> >         ret = 0;
> >
> >         if (wait) {
> > -               i2c_hid_dbg(ihid, "%s: waiting...\n", __func__);
> > +               dev_dbg(&client->dev, "%s: waiting...\n", __func__);
> >                 if (!wait_event_timeout(ihid->wait,
> >                                 !test_bit(I2C_HID_RESET_PENDING, &ihid->flags),
> >                                 msecs_to_jiffies(5000)))
> >                         ret = -ENODATA;
> > -               i2c_hid_dbg(ihid, "%s: finished.\n", __func__);
> > +               dev_dbg(&client->dev, "%s: finished.\n", __func__);
> >         }
> >
> >         return ret;
> > @@ -235,7 +224,7 @@ static int i2c_hid_get_report(struct i2c_client *client, u8 reportType,
> >         int args_len = 0;
> >         u16 readRegister = le16_to_cpu(ihid->hdesc.wDataRegister);
> >
> > -       i2c_hid_dbg(ihid, "%s\n", __func__);
> > +       dev_dbg(&client->dev, "%s\n", __func__);
> >
> >         if (reportID >= 0x0F) {
> >                 args[args_len++] = reportID;
> > @@ -276,7 +265,7 @@ static int i2c_hid_set_report(struct i2c_client *client, u8 reportType,
> >                         size                    /* args */;
> >         int index = 0;
> >
> > -       i2c_hid_dbg(ihid, "%s\n", __func__);
> > +       dev_dbg(&client->dev, "%s\n", __func__);
> >
> >         if (reportID >= 0x0F) {
> >                 args[index++] = reportID;
> > @@ -316,10 +305,9 @@ static int i2c_hid_set_report(struct i2c_client *client, u8 reportType,
> >
> >  static int i2c_hid_set_power(struct i2c_client *client, int power_state)
> >  {
> > -       struct i2c_hid *ihid = i2c_get_clientdata(client);
> >         int ret;
> >
> > -       i2c_hid_dbg(ihid, "%s\n", __func__);
> > +       dev_dbg(&client->dev, "%s\n", __func__);
> >
> >         ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
> >                 0, NULL, 0, NULL, 0);
> > @@ -331,16 +319,15 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
> >
> >  static int i2c_hid_hwreset(struct i2c_client *client)
> >  {
> > -       struct i2c_hid *ihid = i2c_get_clientdata(client);
> >         int ret;
> >
> > -       i2c_hid_dbg(ihid, "%s\n", __func__);
> > +       dev_dbg(&client->dev, "%s\n", __func__);
> >
> >         ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
> >         if (ret)
> >                 return ret;
> >
> > -       i2c_hid_dbg(ihid, "resetting...\n");
> > +       dev_dbg(&client->dev, "resetting...\n");
> >
> >         ret = i2c_hid_command(client, &hid_reset_cmd, NULL, 0);
> >         if (ret) {
> > @@ -354,15 +341,16 @@ static int i2c_hid_hwreset(struct i2c_client *client)
> >
> >  static void i2c_hid_get_input(struct i2c_hid *ihid)
> >  {
> > +       struct i2c_client *client = ihid->client;
> >         int ret, ret_size;
> >         int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
> >
> > -       ret = i2c_master_recv(ihid->client, ihid->inbuf, size);
> > +       ret = i2c_master_recv(client, ihid->inbuf, size);
> >         if (ret != size) {
> >                 if (ret < 0)
> >                         return;
> >
> > -               dev_err(&ihid->client->dev, "%s: got %d data instead of %d\n",
> > +               dev_err(&client->dev, "%s: got %d data instead of %d\n",
> >                         __func__, ret, size);
> >                 return;
> >         }
> > @@ -377,12 +365,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
> >         }
> >
> >         if (ret_size > size) {
> > -               dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
> > +               dev_err(&client->dev, "%s: incomplete report (%d/%d)\n",
> >                         __func__, size, ret_size);
> >                 return;
> >         }
> >
> > -       i2c_hid_dbg(ihid, "input: %*ph\n", ret_size, ihid->inbuf);
> > +       dev_dbg(&client->dev, "input: %*ph\n", ret_size, ihid->inbuf);
> >
> >         if (test_bit(I2C_HID_STARTED, &ihid->flags))
> >                 hid_input_report(ihid->hid, HID_INPUT_REPORT, ihid->inbuf + 2,
> > @@ -423,7 +411,8 @@ static void i2c_hid_init_report(struct hid_report *report, u8 *buffer,
> >                         report->id, buffer, size))
> >                 return;
> >
> > -       i2c_hid_dbg(ihid, "report (len=%d): %*ph\n", size, size, ihid->inbuf);
> > +       dev_dbg(&client->dev, "report (len=%d): %*ph\n", size,
> > +               size, ihid->inbuf);
> >
> >         ret_size = buffer[0] | (buffer[1] << 8);
> >
> > @@ -618,7 +607,7 @@ static int i2c_hid_parse(struct hid_device *hid)
> >         int ret;
> >         int tries = 3;
> >
> > -       i2c_hid_dbg(ihid, "entering %s\n", __func__);
> > +       dev_dbg(&client->dev, "entering %s\n", __func__);
> >
> >         rsize = le16_to_cpu(hdesc->wReportDescLength);
> >         if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
> > @@ -642,7 +631,7 @@ static int i2c_hid_parse(struct hid_device *hid)
> >                 return -ENOMEM;
> >         }
> >
> > -       i2c_hid_dbg(ihid, "asking HID report descriptor\n");
> > +       dev_dbg(&client->dev, "asking HID report descriptor\n");
> >
> >         ret = i2c_hid_command(client, &hid_report_descr_cmd, rdesc, rsize);
> >         if (ret) {
> > @@ -651,7 +640,7 @@ static int i2c_hid_parse(struct hid_device *hid)
> >                 return -EIO;
> >         }
> >
> > -       i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
> > +       dev_dbg(&client->dev, "Report Descriptor: %*ph\n", rsize, rdesc);
> >
> >         ret = hid_parse_report(hid, rdesc, rsize);
> >         kfree(rdesc);
> > @@ -741,10 +730,9 @@ static void i2c_hid_close(struct hid_device *hid)
> >  static int i2c_hid_power(struct hid_device *hid, int lvl)
> >  {
> >         struct i2c_client *client = hid->driver_data;
> > -       struct i2c_hid *ihid = i2c_get_clientdata(client);
> >         int ret = 0;
> >
> > -       i2c_hid_dbg(ihid, "%s lvl:%d\n", __func__, lvl);
> > +       dev_dbg(&client->dev, "%s lvl:%d\n", __func__, lvl);
> >
> >         switch (lvl) {
> >         case PM_HINT_FULLON:
> > @@ -801,8 +789,8 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
> >          * bytes 2-3 -> bcdVersion (has to be 1.00) */
> >         ret = i2c_hid_command(client, &hid_descr_cmd, ihid->hdesc_buffer, 4);
> >
> > -       i2c_hid_dbg(ihid, "%s, ihid->hdesc_buffer: %4ph\n", __func__,
> > -                       ihid->hdesc_buffer);
> > +       dev_dbg(&client->dev, "%s, ihid->hdesc_buffer: %4ph\n", __func__,
> > +               ihid->hdesc_buffer);
> >
> >         if (ret) {
> >                 dev_err(&client->dev,
> > @@ -832,7 +820,7 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
> >                 return -ENODEV;
> >         }
> >
> > -       i2c_hid_dbg(ihid, "Fetching the HID descriptor\n");
> > +       dev_dbg(&client->dev, "Fetching the HID descriptor\n");
> >
> >         ret = i2c_hid_command(client, &hid_descr_cmd, ihid->hdesc_buffer,
> >                                 dsize);
> > @@ -841,7 +829,8 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
> >                 return -ENODEV;
> >         }
> >
> > -       i2c_hid_dbg(ihid, "HID Descriptor: %*ph\n", dsize, ihid->hdesc_buffer);
> > +       dev_dbg(&client->dev, "HID Descriptor: %*ph\n", dsize,
> > +               ihid->hdesc_buffer);
> >
> >         return 0;
> >  }
> > --
> > 1.8.4.rc0
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
