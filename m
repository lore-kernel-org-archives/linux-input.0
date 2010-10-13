From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Wed, 13 Oct 2010 11:26:15 -0700
Message-ID: <20101013182614.GC13094@core.coreip.homeip.net>
References: <1286941662-9774-1-git-send-email-jlee@novell.com>
 <1286941662-9774-2-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1286941662-9774-2-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, linux-input@vger.kernel.org, tiwai@novell.com, trenn@novell.com, jbenc@suse.cz, corentin.chary@gmail.com, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 13, 2010 at 11:47:41AM +0800, Lee, Chun-Yi wrote:
> Add a launch_manager parameter for support to enable Acer Launch Manager
> mode. After enable it, the communication key will stop the default
> behavior to control WLAN/Bluetooth/WWAN rfkill state. It leave usernland
> application to handle the rfkill state changed.
> 

Why would user chose one setup over another? I.e do we really need a
module option or maybe we should pick up behavior and stick to it?

-- 
Dmitry
