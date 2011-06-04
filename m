From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Sat, 4 Jun 2011 15:45:28 +0100
Message-ID: <20110604144527.GA16911@srcf.ucam.org>
References: <4DE8FC4A.9010401@absence.it>
 <4DE8FFE0.5070506@absence.it>
 <20110604084338.GD7194@kamineko.org>
 <20110604124219.GA14809@srcf.ucam.org>
 <4DEA3FBD.8020602@absence.it>
 <20110604143012.GA16615@srcf.ucam.org>
 <4DEA4283.103@absence.it>
 <20110604143638.GA16747@srcf.ucam.org>
 <4DEA4450.80702@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4DEA4450.80702@absence.it>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Jun 04, 2011 at 04:42:24PM +0200, Marco Chiappero wrote:

> More precisely? As far as I know there is no ALS device class; and I
> know nothing about the other.

Where there's no generic implementation of a hardware class that's 
present in multiple pieces of hardware, the first step is to define a 
generic implementation :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
