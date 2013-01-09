From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: i2c-hid: add ACPI support
Date: Wed, 9 Jan 2013 15:52:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301091551580.12134@pobox.suse.cz>
References: <1357742588-11366-1-git-send-email-mika.westerberg@linux.intel.com> <CAN+gG=GrrEdgrCLXvO=xJ6SNeKgHFRobq6RSAfLMfesKkJcijA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=GrrEdgrCLXvO=xJ6SNeKgHFRobq6RSAfLMfesKkJcijA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 9 Jan 2013, Benjamin Tissoires wrote:

> <mika.westerberg@linux.intel.com> wrote:
> > The HID over I2C protocol specification states that when the device is
> > enumerated from ACPI the HID descriptor address can be obtained by
> > executing "_DSM" for the device with function 1. Enable this.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> I'm eager to test it (hopefully next week).
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Perfect. I will wait for your Tested-by: as well before applying to public 
git tree.

Thanks to both of you,

-- 
Jiri Kosina
SUSE Labs
