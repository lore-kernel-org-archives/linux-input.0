From: "Ba, Zheng" <zheng.ba@intel.com>
Subject: Questions on keypad driver upstream submission
Date: Tue, 21 Apr 2009 15:06:09 +0800
Message-ID: <61563CE63B4F854986A895DA7AD3C1771573BC57@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61895 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbZDUHHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2009 03:07:46 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi guys,

I am going to submit a keypad SW driver which is based on next-gen Intel Low Power IA architecture, and it will be put under directory "drivers/input/keyboard/". Since I am really a newbie to upstream submission, I'd like to hear from you and have your inputs on the following questions:

1. What is the process of upstream submission for input drivers? 

2. What are the acceptance criteria? Should the driver be workable or just compliable?

3. How to resolve dependencies? Keypad driver I am going to submit depends on other part of SW drivers for LPIA and the APIs from which are not standard. 

I really appreciate your help on this and look forward to your response.

Thanks,
Zheng

