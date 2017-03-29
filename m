From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: matrix_keypad: add option to drive inactive
 columns
Date: Wed, 29 Mar 2017 00:15:02 -0700
Message-ID: <20170329071502.GC38261@dtor-ws>
References: <20170322201650.9072-1-drivshin@awxrd.com>
 <20170329020229.dm3y57dlzjwilifm@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35566 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753420AbdC2HPG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Mar 2017 03:15:06 -0400
Content-Disposition: inline
In-Reply-To: <20170329020229.dm3y57dlzjwilifm@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: David Rivshin <drivshin@awxrd.com>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 28, 2017 at 09:02:29PM -0500, Rob Herring wrote:
> On Wed, Mar 22, 2017 at 04:16:50PM -0400, David Rivshin wrote:
> > From: David Rivshin <DRivshin@allworx.com>
> > 
> > The gpio-matrix-keypad driver normally sets inactive columns as inputs
> > while scanning. This does not work for all hardware, which may require
> > the inactive columns to be actively driven in order to overcome any
> > pull-ups/downs on the columns.
> > 
> > Signed-off-by: David Rivshin <drivshin@allworx.com>
> > ---
> >  .../devicetree/bindings/input/gpio-matrix-keypad.txt        |  2 ++
> >  drivers/input/keyboard/matrix_keypad.c                      | 13 +++++++++----
> >  include/linux/input/matrix_keypad.h                         |  3 +++
> >  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
