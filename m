From: Alan Ott <alan@signal11.us>
Subject: Re: [PATCH v4 1/2] HID: Add Support for Setting and Getting Feature   Reports from hidraw
Date: Fri, 01 Oct 2010 22:24:09 -0400
Message-ID: <4CA697C9.5020309@signal11.us>
References: <1281442367.12579.206.camel@localhost.localdomain>	<1281990059-3562-2-git-send-email-alan@signal11.us>	<20100930015104.49fc5acf.ospite@studenti.unina.it>	<4CA40605.6080800@signal11.us>	<20101001000309.9bb53de4.ospite@studenti.unina.it> <20101002020008.4812d6a9.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:34821 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996Ab0JBCYK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 22:24:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 112011CCAA8D
	for <linux-input@vger.kernel.org>; Fri,  1 Oct 2010 22:24:10 -0400 (EDT)
In-Reply-To: <20101002020008.4812d6a9.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 10/01/2010 08:00 PM, Antonio Ospite wrote:
> But again, I haven't checked yet what the specs say about byte 0 in the
> returned buffer.

The HID spec is not crystal clear. The best I found was the following:

    The bit length of an item's data is obtained through the Report
    descriptor
    (Report Size * Report Count). Item data is ordered just as items are
    ordered in
    the Report descriptor. If a Report ID tag was used in the Report
    descriptor, all
    reports include a single byte ID prefix. If the Report ID tag was
    not used, all
    values are returned in a single report and a prefix ID is not
    included in that report.

I take it to mean, yes. It says "all reports." It doesn't specifically 
say "all reports on the interrupt endpoint," and it doesn't say "all 
reports on the control endpoint only." It seems to me like it's 
redundant to send it on the control endpoint, which is why I didn't 
originally implement it that way, but Amit Nagal had a device which 
required the report ID in byte zero on the control endpoint, so and 
that's why it sends it that way now.

Alan.

