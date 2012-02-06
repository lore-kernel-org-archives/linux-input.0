From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [patch v3 0/3] Support of Perixx Peripad 701 for hid-multitouch
Date: Mon, 6 Feb 2012 09:39:09 +0100
Message-ID: <20120206083909.GA3972@polaris.bitmath.org>
References: <1328371730-10944-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:43535 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab2BFIhy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2012 03:37:54 -0500
Content-Disposition: inline
In-Reply-To: <1328371730-10944-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> This is the v3 of the support of Perixx Peripad 701.
> 
> I included the changes asked by Henrik & Dmitry:
> -           code = ((usage->hid - 1) & HID_USAGE) + BTN_MOUSE;
> +           code =  BTN_MOUSE + ((usage->hid - 1) & HID_USAGE);
> use of min;
> remove remove the call to input_mt_report_finger_count;
> remove debug information;
> some cosmetic changes (parenthesis, typos)

Looking good now, thanks.

    Acked-by: Henrik Rydberg <rydberg@euromail.se>

Henrik
