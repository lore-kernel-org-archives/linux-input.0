From: Simon Kenyon <simon@koala.ie>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel
 IR  system?
Date: Sat, 28 Nov 2009 09:04:27 +0000
Message-ID: <4B10E79B.2050609@koala.ie>
References: <BDgcsm11qgB@lirc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <BDgcsm11qgB@lirc>
Sender: linux-media-owner@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Christoph Bartelmus wrote:
 > A user friendly GUI tool to configure the mapping of the remote 
buttons is
 > essential for good user experience. I hope noone here considers that 
users
 > learn command line or bash to configure their remotes.

oh please no
the major, major problem with bluetooth is that there is *only* a gui
the core system should use the command line and then a gui (or guis) can 
follow

 > Nobody is manually writing lircd.conf files. Of course you don't want 
the
 > user to know anything about the technical details unless you really 
want
 > to get your hands dirty.

speak for yourself

 > If it ain't broke, don't fix it.

i have been hacking lirc for *so many years* because i needed two 
separate serial inputs. so that is most assuredly broken
