From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] HID: sony: Print reversed MAC address via %pMR
Date: Tue, 19 Dec 2017 19:20:18 +0200
Message-ID: <1513704018.7000.207.camel@linux.intel.com>
References: <20171211130612.34715-1-andriy.shevchenko@linux.intel.com>
         <1DD62093774CEE42AFC16E785A1088049E247090@USCULXMSG13.am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:54894 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750723AbdLSRUW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Dec 2017 12:20:22 -0500
In-Reply-To: <1DD62093774CEE42AFC16E785A1088049E247090@USCULXMSG13.am.sony.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, 2017-12-13 at 02:22 +0000, Colenbrander, Roelof wrote:
> On 12/11/2017 05:07 AM, Andy Shevchenko wrote:
> > Reversed MAC addresses can be printed directly using %pMR specifier.

> Looks good and in a quick test seems to function.
> 
> Acked-by: Roderick Colenbrander <roderick.colenbranderer@sony.com>
> 

Benjamin, perhaps it's good enough to being applied?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
