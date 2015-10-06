From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv9 07/15] cec: add HDMI CEC framework
Date: Tue, 6 Oct 2015 18:06:35 +0100
Message-ID: <20151006170635.GQ21513@n2100.arm.linux.org.uk>
References: <cover.1441633456.git.hansverk@cisco.com>
 <60de2f33f0d4c809f06d23cdac75e3b798aaae4b.1441633456.git.hansverk@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <60de2f33f0d4c809f06d23cdac75e3b798aaae4b.1441633456.git.hansverk@cisco.com>
Sender: linux-media-owner@vger.kernel.org
To: Hans Verkuil <hansverk@cisco.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, thomas@tommie-lie.de, sean@mess.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, lars@opdenkamp.eu, kamil@wypas.org, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 07, 2015 at 03:44:36PM +0200, Hans Verkuil wrote:
> From: Hans Verkuil <hans.verkuil@cisco.com>
> 
> The added HDMI CEC framework provides a generic kernel interface for
> HDMI CEC devices.
> 
> Signed-off-by: Hans Verkuil <hansverk@cisco.com>
> [k.debski@samsung.com: Merged CEC Updates commit by Hans Verkuil]
> [k.debski@samsung.com: Merged Update author commit by Hans Verkuil]
> [k.debski@samsung.com: change kthread handling when setting logical
> address]
> [k.debski@samsung.com: code cleanup and fixes]
> [k.debski@samsung.com: add missing CEC commands to match spec]
> [k.debski@samsung.com: add RC framework support]
> [k.debski@samsung.com: move and edit documentation]
> [k.debski@samsung.com: add vendor id reporting]
> [k.debski@samsung.com: add possibility to clear assigned logical
> addresses]
> [k.debski@samsung.com: documentation fixes, clenaup and expansion]
> [k.debski@samsung.com: reorder of API structs and add reserved fields]
> [k.debski@samsung.com: fix handling of events and fix 32/64bit timespec
> problem]
> [k.debski@samsung.com: add cec.h to include/uapi/linux/Kbuild]
> [k.debski@samsung.com: add sequence number handling]
> [k.debski@samsung.com: add passthrough mode]
> [k.debski@samsung.com: fix CEC defines, add missing CEC 2.0 commands]
> minor additions]
> Signed-off-by: Kamil Debski <kamil@wypas.org>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>

I don't see much in the way of support for source devices in this:
how do we handle hotplug of the sink, and how to do we configure the
physical address?

Surely you aren't proposing that drivers should write directly to
adap->phys_addr without calling some notification function that the
physical address has changed?

Please can you give some guidance on how a HDMI source bridge driver
should deal with these issues.  Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
