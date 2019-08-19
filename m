From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 0/3] HID: intel-ish-hid: support s2idle and s3 in
 ish_suspend()
Date: Mon, 19 Aug 2019 14:06:37 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908191406250.27147@cbobk.fhfr.pm>
References: <20190808102113.27802-1-lixu.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808102113.27802-1-lixu.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Lixu <lixu.zhang@intel.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 8 Aug 2019, Zhang Lixu wrote:

> Currently, the NO_D3 flag is set in ish_probe(), the intel-ish-ipc driver
> puts the ISH into D0i3 when system enter both suspend-to-idle(S0ix) and
> suspend-to-mem(S3). These patches are to put the ISH into D3 when system
> enter S3 and put the ISH into D0i3 when system enter S0ix.
> 
> I tested these patches on the following platforms:
> ISH 5.2: ICL
> ISH 5.0: CNL CFL WHL CML
> ISH 4.0: GLK
> ISH 3.0: KBL
> 
> Test steps:
> * Run the IIO Sensor tool to read the accel_3d sensor data
> * Run cmd "echo mem > /sys/power/state" to suspend-to-mem
> * Press the keyboard to wake up OS.
> * Check if the tool can get the sensor data after OS resume.
> * Run cmd "echo freeze > /sys/power/state" to suspend-to-idle
> * Press the keyboard to wake up OS.
> * Check if the tool can get the sensor data after OS resume.
> 
> Test results:
> The tool can get the accel_3d sensor data after resuming from both
> suspend-to-mem and suspend-to-idle.
> 
> Changes from v1:
> * Fix the indentation issue
> * Elaborate the reason to remove the NO_D3 flag
> * Split the PATCH v1 to three changes, and try to minimize the lines change

Applied to for-5.4/ish. Thanks,

-- 
Jiri Kosina
SUSE Labs
