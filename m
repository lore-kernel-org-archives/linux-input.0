From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: appleir: add support for Apple ir devices
Date: Wed, 17 Apr 2013 18:07:37 +0200
Message-ID: <516EC8C9.8040000@redhat.com>
References: <1366189389-6572-1-git-send-email-benjamin.tissoires@redhat.com> <1614985.S6T7jXBLvD@linux-5eaq.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1614985.S6T7jXBLvD@linux-5eaq.site>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Bastien Nocera <hadess@hadess.net>, Fabien <fabien.andre@gmail.com>, Jarod Wilson <jarod@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 04/17/2013 12:30 PM, Oliver Neukum wrote:
> On Wednesday 17 April 2013 11:03:09 Benjamin Tissoires wrote:
> 
>> +static void appleir_remove(struct hid_device *hid)
>> +{
>> +       struct appleir *appleir = hid_get_drvdata(hid);
>> +       del_timer_sync(&appleir->key_up_timer);
>> +       hid_hw_stop(hid);
>> +       kfree(appleir);
>> +}
> 
> Hi,
> 
> this looks like a race condition. If you get input between
> del_timer_sync() and hid_hw_stop() the timer may be restarted.
> You need to stop the hw first.
> 

ouch. Thanks for spotting this.
Will send a v3 soon.

Cheers,
Benjamin
