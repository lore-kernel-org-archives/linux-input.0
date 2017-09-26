From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] Input: ALPS - remove redundant unlikely()
Date: Tue, 26 Sep 2017 12:11:20 +0200
Message-ID: <20170926101120.GA1370@distanz.ch>
References: <20170926092951.26721-1-tklauser@distanz.ch>
 <20170926095706.GR22190@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:50640 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbdIZKLX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 06:11:23 -0400
Content-Disposition: inline
In-Reply-To: <20170926095706.GR22190@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 2017-09-26 at 11:57:06 +0200, Pali Rohár <pali.rohar@gmail.com> wrote:
> On Tuesday 26 September 2017 11:29:51 Tobias Klauser wrote:
> > IS_ERR_OR_NULL() already implies unlikely(), so it can be omitted.
> 
> Hi Tobias! Exactly same patch was sent 2 years ago. See discussion about
> it why it is not a good idea to apply it:
> 
> https://lists.gt.net/linux/kernel/2269724

Fair enough. Thanks for the explanation.
