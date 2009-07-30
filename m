From: Paul Fox <pgf@laptop.org>
Subject: Re: [PATCH] forced recalibration for the OLPC hgpk touchpad
Date: Thu, 30 Jul 2009 10:37:24 -0400
Message-ID: <18567.1248964644@foxharp.boston.ma.us>
References: <3026.1243972079@foxharp.boston.ma.us> <29774.1248905330@foxharp.boston.ma.us> <20090730061803.C05C3526EC9@mailhub.coreip.homeip.net> (sfid-20090730_014410_549939_B9FD9B58)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751506AbZG3Oh0@vger.kernel.org>
In-reply-to: <20090730061803.C05C3526EC9@mailhub.coreip.homeip.net> (sfid-20090730_014410_549939_B9FD9B58) 
Content-ID: <18564.1248964644.1@foxharp.boston.ma.us>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

hi dmitry --

dmitry wrote:
 > Sorry, I completely forgot about this patch... I am going to apply
 > it, however I think that we should not be creating the attribute
 > if the touchpad does not support recalibration. Also, I don't see
 > the reason why we can't schedule recalibration immediately instead
 > of waiting for 1 msec.
 > 
 > Could you please try updated version of the patch below?

looks and works fine.  thanks!

paul
=---------------------
 paul fox, pgf@laptop.org
