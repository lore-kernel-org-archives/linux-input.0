From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [patch 3/3] HID: multitouch: add support of other generic collections
 in hid-mt
Date: Sat, 21 Dec 2013 21:26:21 +0100
Message-ID: <52B5F96D.9050400@euromail.se>
References: <1387470191-9725-1-git-send-email-benjamin.tissoires@redhat.com> <1387470191-9725-4-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:47287 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab3LUUYb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Dec 2013 15:24:31 -0500
In-Reply-To: <1387470191-9725-4-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Edel Maks <edelmaks@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> The ANTEC Touch Pad is a device which can switch from a multitouch
> touchpad to a mouse. It thus presents several generic collections which
> are currently ignored by hid-multitouch. Enable them by using the generic
> protocol. Adding also a suffix for them depending on their application.

In what way does this and the preceeding patches differ from "else if (is_pen ||
export_all_inputs)"? Adding a functional pattern which then is converted to a
generic case, such that the usual branching is bound to occur anyways, seems
unnecessary.

Thanks,
Henrik

