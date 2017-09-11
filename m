From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] HID: roccat: Fixed false dpi reporting when using osd
 event
Date: Tue, 12 Sep 2017 00:52:50 +0300
Message-ID: <20170911215250.ro5qyxdggniyxfm6@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39835 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdIKVxQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Sep 2017 17:53:16 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: erazor_de@users.sourceforge.net
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Hello Stefan Achatz,

The patch 1c5784da12e3: "HID: roccat: Fixed false dpi reporting when
using osd event" from Aug 27, 2011, leads to the following static
checker warning:

	drivers/hid/hid-roccat-kone.c:784 kone_keep_values_up_to_date()
	warn: potential underflow in kone->profiles[] (-1)-254

drivers/hid/hid-roccat-kone.c
   289   * Writing settings automatically activates startup_profile.
   290   * This function keeps values in kone_device up to date and assumes that in
   291   * case of error the old data is still valid
   292   */
   293  static ssize_t kone_sysfs_write_settings(struct file *fp, struct kobject *kobj,
   294                  struct bin_attribute *attr, char *buf,
   295                  loff_t off, size_t count) {
   296          struct device *dev = kobj_to_dev(kobj)->parent->parent;
   297          struct kone_device *kone = hid_get_drvdata(dev_get_drvdata(dev));
   298          struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
   299          int retval = 0, difference, old_profile;
   300  
   301          /* I need to get my data in one piece */
   302          if (off != 0 || count != sizeof(struct kone_settings))
   303                  return -EINVAL;
   304  
   305          mutex_lock(&kone->kone_lock);
   306          difference = memcmp(buf, &kone->settings, sizeof(struct kone_settings));
   307          if (difference) {
   308                  retval = kone_set_settings(usb_dev,
   309                                  (struct kone_settings const *)buf);
   310                  if (retval) {
   311                          mutex_unlock(&kone->kone_lock);
   312                          return retval;
   313                  }
   314  
   315                  old_profile = kone->settings.startup_profile;
   316                  memcpy(&kone->settings, buf, sizeof(struct kone_settings));
   317  
   318                  kone_profile_activated(kone, kone->settings.startup_profile);
   319  
   320                  if (kone->settings.startup_profile != old_profile)
   321                          kone_profile_report(kone, kone->settings.startup_profile);
                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
As near as I can tell, event->value comes from settings.startup_profile
here.  We're writing a config file so sysfs in this function.  We do
a memcmp() and ignore it if there is no difference between the settings
we have and the new settings.  Then in kone_set_settings() we write
the settings to hardware.  It's possible that the hardware checks
that the profile is in the 1-5 range and returns an error if it's out
of bounds, but I don't know.

Some of the other drivers check that .startup_profile is in bounds.

   322          }
   323          mutex_unlock(&kone->kone_lock);
   324  
   325          return sizeof(struct kone_settings);
   326  }

[ snip ]

   778  /* handle special events and keep actual profile and dpi values up to date */
   779  static void kone_keep_values_up_to_date(struct kone_device *kone,
   780                  struct kone_mouse_event const *event)
   781  {
   782          switch (event->event) {
   783          case kone_mouse_event_switch_profile:
   784                  kone->actual_dpi = kone->profiles[event->value - 1].
                                                          ^^^^^^^^^^^^^^^^
Potential read out of bounds here.

   785                                  startup_dpi;
   786          case kone_mouse_event_osd_profile:
   787                  kone->actual_profile = event->value;
   788                  break;
   789          case kone_mouse_event_switch_dpi:
   790          case kone_mouse_event_osd_dpi:
   791                  kone->actual_dpi = event->value;
   792                  break;
   793          }
   794  }

regards,
dan carpenter
