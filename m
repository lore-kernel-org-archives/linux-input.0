From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] touchscreen: Cypress TTSP G3 MTDEV Core Driver
Date: Wed, 01 Dec 2010 15:38:48 +0100
Message-ID: <4CF65DF8.2010806@euromail.se>
References: <Kevin McNeely <kev@cypress.com> <1289327120-2612-1-git-send-email-kev@cypress.com> <4CE163CC.1060202@euromail.se> <FB9C2CB29A07AB45B575A4E8D2AABC090119784D@labamba.mis.cypress.com> <4CF5F7BA.7070909@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:33585 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753113Ab0LAOjl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Dec 2010 09:39:41 -0500
In-Reply-To: <4CF5F7BA.7070909@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Kevin McNeely <Kevin.McNeely@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brown <davidb@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Simtec Linux Team <linux@simtec.co.uk>, Luotao Fu <l.fu@pengutronix.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>>>

>>> Thanks for your submission. Please find comments on MT inline. On a
>>> general
>>> note, it is strongly recommended that this driver be converted to the
>>> MT slots
>>> (type B) protocol.
>>
>> I will resubmit with Protocol A only at this time.  I will remove the
>> Tracking ID's.
>>
> 
> Any comments on this?


It is not optimal, but it is not wrong. If the plan is to support kernels 2.6.38
and later, I strongly recommend using the type B protocol, as already stated.

Henrik
