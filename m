From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: disable repeat on single key
Date: Tue, 16 Sep 2008 12:59:41 -0400
Message-ID: <20080916165938.GB9252@amd.corenet.prb>
References: <f96d234e0809150717i5f393008u4988e91ef5c23738@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:41293 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbYIPQ7u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Sep 2008 12:59:50 -0400
Received: by gxk9 with SMTP id 9so27882440gxk.13
        for <linux-input@vger.kernel.org>; Tue, 16 Sep 2008 09:59:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f96d234e0809150717i5f393008u4988e91ef5c23738@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Cliff,

On Mon, Sep 15, 2008 at 10:17:59AM -0400, Cliff Brake wrote:
> Is there any way in the Linux input layer to disable repeat on a
> single key vs the entire device?
> 

No, there is not. If your device require fine-grained repeat control you
will have to implement it in the driver.

-- 
Dmitry
