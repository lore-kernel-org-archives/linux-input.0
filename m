From: Ed Tomlinson <edt@aei.ca>
Subject: Re: [PATCH 0/2] Provide a driver for the Apple Magic Mouse - opps
Date: Tue, 16 Feb 2010 07:34:47 -0500
Message-ID: <201002160734.47588.edt@aei.ca>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz> <201002140922.42014.edt@aei.ca> <20100215071145.GA9135@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100215071145.GA9135@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Monday 15 February 2010 02:11:46 Dmitry Torokhov wrote:
> Almost... you need to do hid_hw_stop() first and only then unregister
> input device, Otherwise if you unload the module while moving the mouse
> it is likely to still oops.

The exit routing for the module also has a hid_hw_stop.  Is it going to cause
problems when it gets called twice?

TIA
Ed
