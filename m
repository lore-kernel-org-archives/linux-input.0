From: dturvene <dturvene@dahetral.com>
Subject: ACPI and the psmouse alps driver
Date: Fri, 25 Jan 2013 11:07:49 -0500
Message-ID: <5102ADD5.1020900@dahetral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dahetral.com ([128.177.27.153]:56262 "EHLO dahetral.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756837Ab3AYQHu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jan 2013 11:07:50 -0500
Received: from [192.168.1.13] (pool-108-28-181-146.washdc.fios.verizon.net [108.28.181.146])
	(authenticated bits=0)
	by dahetral.com (8.13.8/8.13.8) with ESMTP id r0PG7nwB008691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 25 Jan 2013 11:07:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

While I'm thinking of it, in the my last alps driver dkms, I put in an 
ACPI interface to uniquely detect the touchpad type.  After spending a 
good couple of days figuring out the ACPI spec and this mysterious _HID 
(hardware id) and _CID (compatibility id) as it relates to how ALPS 
identifies its touchpads, I can confirm Linus' quote "ACPI is a complete 
design disaster in every way. But we're kind of stuck with it."   Some 
ALPS touchpads have different _HID values.  Some have the same _HID but 
different behavior.

As far as I can tell ACPI has varying degrees of usefulness based on the 
h/w manufacturer.  The ALPS MS Windows drivers appear to use ACPI to 
figure out if the touchpad is, in fact, from ALPS and then a complicated 
series of proprietary retrievals to figure out the behavior.


