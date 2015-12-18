From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RESEND] Lenovo Yoga 900 touchpad issues
Date: Fri, 18 Dec 2015 16:42:09 +0200
Message-ID: <20151218144209.GK1762@lahna.fi.intel.com>
References: <CAOhV88MGoJdUzty=DDTLOkd7me5uoRWwTTrR8aD=zf5ga0_Hew@mail.gmail.com>
 <20151216092858.GP1762@lahna.fi.intel.com>
 <CAOhV88Mv+RUADPHT5AwD=dR-VdPn7Cmf4TkJoaBjNA4Q6zL6WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOhV88Mv+RUADPHT5AwD=dR-VdPn7Cmf4TkJoaBjNA4Q6zL6WQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 16, 2015 at 02:58:11PM -0800, Nish Aravamudan wrote:
> With the patch applied to my patched 4.4-rc5, things seem to be
> working now. I do get one "failed to reset device" message in the
> logs, but then I'm guessing the second one succeeds and I don't see
> the "failed to resume" message.

I finally got the yoga 900 machine.

This is what happens when I have "i2c_hid.debug=1" in the kernel command
line (I stripped out non-related messages and added few more debug
prints):

<resume by pressing power button>

  [   72.410282] i2c_hid i2c-SYNA2B29:00: enabled IRQ
  [   72.410285] i2c_hid i2c-SYNA2B29:00: i2c_hid_hwreset
  [   72.410288] i2c_hid i2c-SYNA2B29:00: i2c_hid_set_power
  [   72.410291] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=22 00 00 08
  [   72.412879] i2c_hid i2c-SYNA2B29:00: resetting...
  [   72.412883] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=22 00 00 01

Now we sent out reset command and wait for the interrupt to happen.

  [   72.413248] i2c_hid i2c-SYNA2B29:00: input: 06 00 01 00 00 00

We get interrupt here but the received message did not have first two
bytes zeroed as expected by the driver and the i2c-hid spec so we think
it is an input report!

  [   72.413266] i2c_hid i2c-SYNA2B29:00: i2c_hid_set_or_send_report
  [   72.413270] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=22 00 3f 03 0f 23 00 04 00 0f 01

  [   72.413416] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: waiting...

Here we start actually waiting for the interrupt which already
happened.

  [   72.413751] i2c_hid i2c-SYNA2B29:00: i2c_hid_set_or_send_report
  [   72.413755] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=25 00 17 00 09 01 42 00 2e 00 19 19 00 10 cc 06 74 04 0f 19 00 00 00 00 00
  [   77.413135] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: finished.
  [   77.413137] i2c_hid i2c-SYNA2B29:00: failed to reset device.

And after 5 seconds we report error.

  [   77.413138] i2c_hid i2c-SYNA2B29:00: i2c_hid_set_power
  [   77.413139] i2c_hid i2c-SYNA2B29:00: __i2c_hid_command: cmd=22 00 01 08
  [   77.415030] i2c_hid i2c-SYNA2B29:00: reset returned: -61
  [   77.415035] dpm_run_callback(): i2c_hid_resume+0x0/0xe0 returns -61
  [   77.415037] PM: Device i2c-SYNA2B29:00 failed to resume: error -61

On another occasion the faulty input report was received immediatelly
after we call i2c_hid_set_power().

With below hack patch suspend/resume works fine but it is far from being
suitable for merging. Still, it would be nice if you could try it out
and see if it helps in your case.

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 10bd8e6..1c6969f 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -354,14 +354,19 @@ static int i2c_hid_hwreset(struct i2c_client *client)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	int ret;
 
+	disable_irq(ihid->irq);
+
 	i2c_hid_dbg(ihid, "%s\n", __func__);
 
 	ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
-	if (ret)
+	if (ret) {
+		enable_irq(ihid->irq);
 		return ret;
+	}
 
 	i2c_hid_dbg(ihid, "resetting...\n");
 
+	enable_irq(ihid->irq);
 	ret = i2c_hid_command(client, &hid_reset_cmd, NULL, 0);
 	if (ret) {
 		dev_err(&client->dev, "failed to reset device.\n");
@@ -390,16 +395,14 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		return;
 	}
 
-	ret_size = ihid->inbuf[0] | ihid->inbuf[1] << 8;
-
-	if (!ret_size) {
-		/* host or device initiated RESET completed */
-		if (test_and_clear_bit(I2C_HID_RESET_PENDING, &ihid->flags))
-			wake_up(&ihid->wait);
+	/* host or device initiated RESET completed */
+	if (test_and_clear_bit(I2C_HID_RESET_PENDING, &ihid->flags)) {
+		wake_up(&ihid->wait);
 		return;
 	}
 
-	if (ret_size > size) {
+	ret_size = ihid->inbuf[0] | ihid->inbuf[1] << 8;
+	if (ret_size > size || !ret_size) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;
