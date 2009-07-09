From: Alessio Sangalli <alesan@manoweb.com>
Subject: Completely new input driver
Date: Thu, 09 Jul 2009 11:40:35 -0700
Message-ID: <4A5639A3.70801@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60787 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbZGISkj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 14:40:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi I've written a "test" driver in the form of a standard character 
device driver to interface with a special keyboard + pointing device. I 
used the char device approach for testing; it already delivers 
input_event structures.

Now my question is, what is the best way to fit this in the Linux input 
subsystem?

Thank you!
Alessio


