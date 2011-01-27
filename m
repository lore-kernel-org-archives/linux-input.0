From: Terry Lambert <tlambert@google.com>
Subject: Interface for regression testing & input event capture/replay?
Date: Thu, 27 Jan 2011 11:58:38 -0800
Message-ID: <AANLkTim5_sFHphygm2enEDFc7GNKd=M0h6hSvT2QeyCP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:22166 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab1A0T6m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 14:58:42 -0500
Received: from kpbe20.cbf.corp.google.com (kpbe20.cbf.corp.google.com [172.25.105.84])
	by smtp-out.google.com with ESMTP id p0RJwe7g010560
	for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 11:58:40 -0800
Received: from yic1 (yic1.prod.google.com [10.243.65.129])
	by kpbe20.cbf.corp.google.com with ESMTP id p0RJwceF027483
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 11:58:39 -0800
Received: by yic1 with SMTP id 1so793804yic.11
        for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 11:58:38 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi;

I'm looking for some guidance from Linux/input people...

I've looked through the archives, and around the net a bit, and I
haven't been able to find anything to capture events from an arbitrary
set of inputs, and then replay them back to software attached to those
inputs.

This would be useful for:

o Regression testing user space algorithms
o Training software for gesture recognition
o Tuning drivers for new hardware to correct self-censor undesirable events
o Probably lots of other things I haven't thought of

The multiple event sources requirement comes from using things like
keyboard modifier keys to change mouse button behaviours.  The most
obvious example is probably option-click on Apple hardware with a one
button mouse.

The basic problems with just opening up /dev/eventX, /dev/eventY, ...
and listening/injecting are:

o If a piece of software grabs the input, I don't get events
o If I grab the input, the software I'm testing doesn't get events
o If neither of us grabs the input, filters apply
o If the input is grabbed by someone, you can't inject events
o It won't work if the event consuming software lives in kernel space

The basic problems with using the filter mechanism are:

o Filters are applied after grabs, so if it's grabbed the filter is not invoked
    (I read the thread introducing filters; this makes sense)
o You can only have one filter at a time
    (there might already be one)

Has anyone tried to solve this problem before?  Any suggestions?

Thanks,
-- Terry
