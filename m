From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: alps: allow incoming reports when only the trackstick
 is opened
Date: Fri, 26 Oct 2018 17:27:41 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810261727320.23511@cbobk.fhfr.pm>
References: <20181012140525.24799-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012140525.24799-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 12 Oct 2018, Benjamin Tissoires wrote:

> If userspace only reads the trackstick node, and no one is listening to
> the touchpad nor the hidraw node then, the device is not powered on.
> 
> Add open/close callbacks to allow users to disable the touchpad in Gnome
> while keeping the trackstick active.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1559632
> Link: https://gitlab.gnome.org/GNOME/mutter/issues/128
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
