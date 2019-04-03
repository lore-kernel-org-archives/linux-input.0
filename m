From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v5] HID: intel-ish-hid: ISH firmware loader client
 driver
Date: Wed, 3 Apr 2019 15:11:02 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1904031510430.9803@cbobk.fhfr.pm>
References: <1554184061-2872-1-git-send-email-rushikesh.s.kadam@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554184061-2872-1-git-send-email-rushikesh.s.kadam@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Cc: srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com, ncrews@chromium.org, jettrink@chromium.org, gwendal@google.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2 Apr 2019, Rushikesh S Kadam wrote:

> This driver adds support for loading Intel Integrated
> Sensor Hub (ISH) firmware from host file system to ISH
> SRAM and start execution.
> 
> At power-on, the ISH subsystem shall boot to an interim
> Shim loader-firmware, which shall expose an ISHTP loader
> device.
> 
> The driver implements an ISHTP client that communicates
> with the Shim ISHTP loader device over the intel-ish-hid
> stack, to download the main ISH firmware.
> 
> Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Acked-by: Nick Crews <ncrews@chromium.org>
> Tested-by: Jett Rink <jettrink@chromium.org>

Now queued in for-5.2/ish. Thanks,

-- 
Jiri Kosina
SUSE Labs
