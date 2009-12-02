From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 2/2] Input: msi-wmi - switch to using sparse keymap
	library
Date: Wed, 2 Dec 2009 10:48:42 -0800
Message-ID: <20091202184842.GB20530@core.coreip.homeip.net>
References: <20091202192603.3e1de98a@destiny.ordissimo> <20091202192812.7e9919fb@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:55678 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbZLBSsp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2009 13:48:45 -0500
Content-Disposition: inline
In-Reply-To: <20091202192812.7e9919fb@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>

On Wed, Dec 02, 2009 at 07:28:12PM +0100, Anisse Astier wrote:
>  
>  static void __exit msi_wmi_exit(void)

Anisse,

It does not look like you are freeing sparse keymap when you
unnregistering input device, otherwise looks good.

-- 
Dmitry
