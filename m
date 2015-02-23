From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 7/7] thinkpad_acpi: use DEVICE_ATTR_* macros
Date: Mon, 23 Feb 2015 07:25:22 -0300
Message-ID: <1424687122.3034736.231116061.6D0FF46D@webmail.messagingengine.com>
References: <1424443481.22910.19.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424443481.22910.19.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 20, 2015, at 11:44, Bastien Nocera wrote:
> Use the DEVICE_ATTR_RW macro to reduce boiler plate

So far, so good, but you also used the DEVICE_ATTR_RO macro...

> and move the attribute declaration to get rid of function signatures.

I didn't see any "move the attribute declaration" done in this patch.

Other than that, looks good.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
