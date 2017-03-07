From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/3] Input: alps - cleanup
Date: Tue, 7 Mar 2017 09:44:28 -0800
Message-ID: <20170307174428.GB13740@dtor-ws>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
 <1488626666-16577-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488626666-16577-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 04, 2017 at 12:24:23PM +0100, Pali Rohár wrote:
> This patch series cleanup usage of alps_model_data table.
> 
> Changes since v1: Patches for ALPS_PROTO_V6 and ALPS_PROTO_V1 were
> dropped and support for those touchpad are still in alps_model_data.
> 
> Pali Rohár (3):
>   Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
>   Input: alps - warn about unsupported ALPS V9 touchpad
>   Input: alps - cleanup alps_model_data
> 
>  drivers/input/mouse/alps.c |   75 +++++++++++++++++++++++++-------------------
>  drivers/input/mouse/alps.h |    6 +---
>  2 files changed, 43 insertions(+), 38 deletions(-)

Applied the lot, thank you.

-- 
Dmitry
