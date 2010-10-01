From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 1/2] Add acer wmi hotkey events support
Date: Fri, 1 Oct 2010 19:16:13 +0100
Message-ID: <201010011916.14175.carlos@strangeworlds.co.uk>
References: <1285941088-31196-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1285941088-31196-1-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, tiwai@novell.com, trenn@novell.com, jbenc@suse.cz, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

On Friday 01 October 2010 14:51:27 Lee, Chun-Yi wrote:
> Add acer wmi hotkey event support. Install a wmi notify handler to
> transfer wmi event key to key code, then send out keycode through acer
> wmi input device to userland.

What hardware is this for? Up to now, all Acer hardware I'm aware of has 
always sent key codes. This and the other patch seem to be for something 
that's quite different to the current batch of hardware supported by acer-wmi?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
