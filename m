From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/3] HID: sensor-hub: don't limit the driver only to USB
 bus
Date: Mon, 18 Feb 2013 10:28:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1302181028410.17024@pobox.suse.cz>
References: <1360578679-7029-1-git-send-email-mika.westerberg@linux.intel.com> <1360578679-7029-3-git-send-email-mika.westerberg@linux.intel.com> <CAN+gG=ECOFVjeWtgxixd6iMdp5HkSBJQE3LPzsLtowjY6D=4tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=ECOFVjeWtgxixd6iMdp5HkSBJQE3LPzsLtowjY6D=4tA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, srinivas.pandruvada@intel.com
List-Id: linux-input@vger.kernel.org

On Mon, 11 Feb 2013, Benjamin Tissoires wrote:

> > We now have two transport mediums: USB and I2C, where sensor hubs can
> > exists. So instead of constraining the driver to only these two we let it
> > to match any HID bus as long as the group is HID_GROUP_SENSOR_HUB.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks a lot Mika, I have now applied the series for 3.9

-- 
Jiri Kosina
SUSE Labs
